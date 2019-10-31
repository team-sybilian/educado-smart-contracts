const HelloWorld = artifacts.require("HelloWorld");

contract("HelloWorld", accounts => {
  it("should return 'Hello World!' string", function() {
    return HelloWorld.deployed().then(instance => {
        console.log(instance.helloWorld.call());
    })
  });
});
