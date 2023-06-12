const UnpunkedSound = artifacts.require('UnpunkedSound');
const UnpunkedSoundDAO = artifacts.require('UnpunkedSoundDAO');

contract('UnpunkedSound', (accounts) => {
  it('should give the total supply of tokens to the owner', async () => {
    let instance = await UnpunkedSound.deployed();
    let balance = await instance.balanceOf.call(accounts[0]);
    assert.equal(balance.toString(), '69000');
  });

  it('should allow token holders to propose', async () => {
    let tokenInstance = await UnpunkedSound.deployed();
    let daoInstance = await UnpunkedSoundDAO.deployed();

    await daoInstance.propose("Should we invest in marketing?", { from: accounts[0] });
    let proposal = await daoInstance.proposals(0);

    assert.equal(proposal.question, "Should we invest in marketing?");
    assert.equal(proposal.proposer, accounts[0]);
  });
});
