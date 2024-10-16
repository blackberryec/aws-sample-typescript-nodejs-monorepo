.PHONY: clean build zip sam-build test

LAMBDA_DIRS=$(wildcard lambdas/*)
LAYER_DIRS=$(wildcard layers/*)
PLATFORM="node"
NODE_TARGET="node20"
DIST="dist"
DIST_LAMBDA="dist/lambdas"
DIST_LAYER="dist/layers"

# Clean the dist folder
clean:
	@echo "Cleaning dist folder..."
	rm -rf dist/

# Build all lambdas and layers using esbuild
build: clean
	@echo "Building lambdas and layers with esbuild..."
	@mkdir -p $(DIST_LAMBDA) ${DIST_LAYER}
	@for lambda in $(LAMBDA_DIRS); do \
		echo "Building $$lambda..."; \
		npx esbuild $$lambda/app.ts --bundle --platform=$(PLATFORM) --target=${NODE_TARGET} --outdir=${DIST}/$$lambda --external:aws-sdk; \
	done
	@for layer in $(LAYER_DIRS); do \
		echo "Building $$layer..."; \
		npx esbuild $$layer/**.ts --bundle --platform=$(PLATFORM) --target=${NODE_TARGET} --outdir=${DIST}/$$layer/nodejs/node20/node_modules; \
	done

# Zip all lambdas and layers for deployment
zip: build
	@echo "Zipping lambdas and layers..."
	@for lambda in $(LAMBDA_DIRS); do \
		echo "Zipping $$lambda..."; \
		(cd $(DIST)/$$lambda && zip -r ../../$$lambda.zip *); \
	done
	@for layer in $(LAYER_DIRS); do \
		echo "Zipping $$layer..."; \
		(cd $(DIST)/$$layer && zip -r ../../$$layer.zip *); \
	done

# Build using SAM CLI with Docker
sam-build: zip
	@echo "Building SAM application..."
	sam build --use-container
	
# Invoke a specific function locally
sam-local-invoke:
	@read -p "Enter the Lambda function name (from template.yaml): " function_name; \
	sam local invoke $$function_name

# SAM Local: Start the local API Gateway and invoke functions via HTTP
sam-local-api: build
	@echo "Starting local API Gateway..."
	sam local start-api

# SAM Local: Start the Lambda runtime locally for event-driven invocations
sam-local-lambda: sam-build
	@echo "Starting local Lambda runtime..."
	sam local start-lambda

# Run tests using Jest
test:
	@echo "Running tests..."
	npx jest --coverage
