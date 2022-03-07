# Wave Portal Smart Contract

## Run Smart Contract

```shell
npx hardhat accounts
```

## Deploy to Rinkeby

```shell
npx hardhat run scripts/deploy.js --network rinkeby
```

## Test your Smart Contract

```shell
npx hardhat run scripts/run.js
```

This will:

1. Creating a new local Ethereum network.
2. Deploying your contract.
3. Then, when the script ends Hardhat will automatically destroy that local network.

## Deploy locally

Start a local Ethereum network thats stays alive

```shell
npx hardhat node
```

Now deploy to localhost

```shell
npx hardhat run scripts/deploy.js --network localhost
```

