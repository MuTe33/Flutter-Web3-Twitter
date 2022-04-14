const main = async () => {
    const tweetContractFactory = await hre.ethers.getContractFactory("TwitterFeed");
    const tweetContract = await tweetContractFactory.deploy({
      value: hre.ethers.utils.parseEther("0.1"),
    });
    await tweetContract.deployed();
    console.log("Contract address:", tweetContract.address);
  
    /*
     * Get Contract balance
     */
    let contractBalance = await hre.ethers.provider.getBalance(
      tweetContract.address
    );
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    );
  
    /*
     * Send Wave
     */
    let tweetTxn = await tweetContract.tweet("A message!");
    await tweetTxn.wait();

    const tweetTxn2 = await tweetContract.tweet("This is tweet #2");
    await tweetTxn2.wait();
  
    /*
     * Get Contract balance to see what happened!
     */
    contractBalance = await hre.ethers.provider.getBalance(tweetContract.address);
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    );
  
    let allTweets = await tweetContract.getAllTweets();
    console.log(allTweets);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();