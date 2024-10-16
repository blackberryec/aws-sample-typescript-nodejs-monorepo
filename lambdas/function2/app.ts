import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { sharedLogic } from '../../shared/utils';
import { Logger } from '@aws-lambda-powertools/logger';

const logger = new Logger({ serviceName: 'lambda function 2' });

export const lambdaHandler = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  const message = sharedLogic();
  logger.info(message);
  
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: `Hello from Function 2! ${message}`,
    }),
  };
};
