const UnpunkedSound = artifacts.require('UnpunkedSound');
const UnpunkedSoundDAO = artifacts.require('UnpunkedSoundDAO');

module.exports = function(deployer) {
  deployer.deploy(UnpunkedSound).then(function() {
    return deployer.deploy(UnpunkedSoundDAO, UnpunkedSound.address);
  });
};
