(async function () {
    try {
        console.log("🍌---------------------------------------🍌");
        console.log("🍽️  PREPARING THE BANANA FEAST...");
        console.log("🍌---------------------------------------🍌");

        // 1. Get the Head Chef (You)
        const accounts = await web3.eth.getAccounts();
        const headChef = accounts[0];
        console.log("👨‍🍳 Head Chef (Deployer) is ready at table:", headChef);

        // 2. Fetch the Recipe (The Artifacts)
        console.log("📜 Reading the Banana Recipe...");
        const metadata = JSON.parse(await remix.call('fileManager', 'getFile', 'artifacts/MyCrypto_Banana.json'));
        
        // 3. Prep the Kitchen
        let contract = new web3.eth.Contract(metadata.abi);
        
        // 4. Decide Portion Size
        const totalBananas = "1000000000000000000000000";
        console.log("📦 Loading 1,000,000 Bananas into the truck...");

        console.log("⏳ Peeling the bananas and sending to the blockchain...");

        // 5. Serve the Dish (Deploy)
        const newContractInstance = await contract.deploy({
            data: metadata.data.bytecode.object,
            arguments: [totalBananas]
        }).send({
            from: headChef,
            gas: 3000000,
            gasPrice: '30000000000'
        });

        console.log("✅ ORDER UP! The Bananas are served!");
        console.log("📍 Banana Stand Location (Address):", newContractInstance.options.address);
        
        // 6. Taste Test
        const name = await newContractInstance.methods.name().call();
        const symbol = await newContractInstance.methods.symbol().call();
        
        console.log("📝 Menu Item:", name);
        console.log("🔤 Short Code:", symbol);
        console.log("🍌---------------------------------------🍌");
        console.log("🤤  Ready to eat!");

    } catch (e) {
        console.log("🤮 Kitchen Disaster (Error):", e.message);
    }
})();