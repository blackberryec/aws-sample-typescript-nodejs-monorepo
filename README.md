# AWS Serverless Application

This project is an AWS Serverless application built using AWS SAM, TypeScript, NPM for dependency management, and esbuild for optimizing the deployment package size. The application includes Lambda functions, shared Layers, and automated local packaging for testing and deployment.

## Project Structure

```plaintext
aws-serverless-app/
│
├── api/                         # OpenAPI specification for API Gateway
│   └── openapi.yaml
│
├── lambdas/                     # Contains all Lambda functions
│   ├── function1/               # First Lambda function (business logic)
│   ├── function2/               # Second Lambda function (business logic)
│
├── shared/                      # Shared code
│   └── utils.ts                 # Shared utility functions used by lambdas
│
├── layers/                      # Directory for Lambda Layers
│   ├── layer1/                  # First shared Lambda layer
│   ├── layer2/                  # Second shared Lambda layer
│
├── dist/                        # Directory for build outputs and zipped artifacts
│   ├── lambdas/
│   ├── layers/
│   ├── shared/
│
├── .env                         # Environment variables for local development
│
├── .gitignore                   # Files and directories to ignore in version control
│
├── Makefile                     # Automates build, packaging, testing, and deployment tasks
│
├── template.yaml                # SAM template for defining the serverless application
│
├── tsconfig.json                # TypeScript configuration
│
├── package.json                 # NPM scripts and project dependencies
│
├── README.md                    # Documentation for the project
│
└── tests/                       # Unit tests for lambdas, layers, and shared utilities
    ├── layers/
    ├── lambdas/
    ├── shared/
```

## Prerequisites

- Node.js 20.18: The latest version of Node.js used in the project.
- NPM 10.8.2: Node package manager to manage dependencies.
- NVM 0.40.1: Node Version Manager, to handle Node.js version management.
- AWS SAM CLI: AWS Serverless Application Model CLI for packaging, deploying, and running SAM applications locally.
- Make: A build automation tool used for task automation.
- Docker: Required to run sam build and sam local commands locally for Lambda and API Gateway.

## Setup

1. **Install Dependencies**

   ```bash
   nvm use
   npm install
   ```

2. **Build the Application**

   ```bash
   make build
   ```

3. **Run Tests**

   ```bash
   make test
   ```

## Adding New Dependencies

   If you need to add a new dependency (like a library or package). For example, to add a new `@aws-lambda-powertools/logger` package:

   ```bash
   npm i @aws-lambda-powertools/logger
   ```

## Environment Variables

Use the .env file to define local environment variables. These variables will be loaded automatically during local testing and can be accessed within the Lambda functions.

## Notes

- **ESBuild**: This project uses esbuild for bundling and optimizing the TypeScript Lambda functions. Esbuild enables fast builds and includes tree-shaking to reduce deployment package size.
- **Shared**: Shared are used to share common code (like utility functions or libraries) between multiple Lambda functions without provisioning infrastructure layers.
- **Layers**: Lambda layers are used to share common code (like utility functions or libraries) between multiple Lambda functions. This helps avoid redundancy and reduces deployment package sizes.
- **Testing**: All Lambda functions, shared utilities, and layers are covered by unit tests using Jest. It is recommended to add tests for any new features or changes.
