FI-API
======

Here be dragons...


Getting started
---------------

### Install dependencies

```sh
npm install
```

### Set ENV_VARIABLES

  * `FI_API__STORAGE_ACCOUNT=figeodata`
  * `FI_API__STORAGE_SECRET`

*The keys are stored here:
[FI-meta](https://github.com/FreudenbergGroup/FI-meta/blob/master/Secrets/fi-api_keys.sh)
(private)*

### Run Tests with grunt.

Before running the test, the NODE_PATH must be set to '.'. Setting them *after*
starting the node process, i.e. Grunt, doesn't work :(

```sh
NODE_PATH=. grunt test
```

or

```sh
npm test
```

For continous testing do

```sh
NODE_PATH=. grunt test watch
```

or

```sh
npm test && grunt watch
```

There is also `grunt test:integration` which runs the integration tests. These tests require valid API keys to work
though.
