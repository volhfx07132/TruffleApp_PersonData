const PersonData = artifacts.require("Migrations");

module.exports = function (deployer) {
  deployer.deploy(PersonData);
};
