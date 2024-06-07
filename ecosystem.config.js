module.exports = {
  apps: [{
    name: 'server.js',
    script: './server.js',
    env_production: {
      NODE_ENV: 'production',
    },
    env: {
      NODE_ENV: 'development',
    }
  }],
};
