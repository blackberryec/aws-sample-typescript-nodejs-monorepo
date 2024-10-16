module.exports = {
  preset: "ts-jest",
  transform: {
    "^.+\\.ts?$": "ts-jest",
  },
  moduleFileExtensions: ["js", "ts"],
  collectCoverageFrom: ["**/lambdas/**/*.ts", "!**/node_modules/**"],
  testMatch: ["**/tests/**/*.test.ts"],
  testPathIgnorePatterns: ["/node_modules/"],
  testEnvironment: "node",
  coverageProvider: "v8",
};