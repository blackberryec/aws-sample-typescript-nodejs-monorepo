import { lambdaHandler } from '../../lambdas/function1/app';

test('lambdaHandler returns correct response', async () => {
  const response = await lambdaHandler({} as any);
  expect(response.statusCode).toBe(200);
  expect(JSON.parse(response.body).message).toContain('Hello from Function 1');
});
