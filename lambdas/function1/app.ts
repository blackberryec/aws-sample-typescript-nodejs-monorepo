import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { sharedLogic } from '../../shared/utils';

export const lambdaHandler = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  const message = sharedLogic();
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: `Hello from Function 1! ${message}`,
    }),
  };
};
