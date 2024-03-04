#!/bin/sh

ng new $1 --defaults --standalone --routing
cd $1
npm uninstall @types/jasmine jasmine-core karma karma-chrome-launcher karma-coverage karma-jasmine karma-jasmine-html-reporter
rm -rf node_modules/
npm install -D jest @types/jest

cat <<EOF > jest.config.ts
module.exports = {
setupFilesAfterEnv: ['<rootDir>/setup-jest.ts'],
};
EOF

npm install ng-mocks @testing-library/angular @testing-library/jest-dom jest-environment-jsdom eslint @angular/language-service --save-dev

cat <<EOF > setup-jest.js
import '@testing-library/jest-dom';
EOF

sed -i 's/karma/jest/' angular.json
sed -i 's/jasmine/jest/' tsconfig.spec.json

sed -i '/"assets"/,/"scripts"/d' angular.json
