const request = require('supertest');

const app = require('./app');

describe('Smoke tests', () => {
  test('/', done => {
    request(app)
      .get('/')
      .then(res => {
        expect(res.statusCode).toBe(200);
        done();
      });
  });

  test('/robots.txt', done => {
    request(app)
      .get('/robots.txt')
      .then(res => {
        expect(res.statusCode).toBe(200);
        done();
      });
  });
});
