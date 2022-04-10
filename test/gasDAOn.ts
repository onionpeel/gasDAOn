import {expect} from "./chai-setup";
import {ethers, deployments} from 'hardhat';
import { Deployment } from "hardhat-deploy/dist/types";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import {setup} from './utils/index';
import type { GasDAOn } from '../typechain-types';


describe('GasDAOn', () => {
  let gasDAOn: GasDAOn;
  let planetaryArsonist1: SignerWithAddress
  let planetaryArsonist2: SignerWithAddress
  let charburger1: SignerWithAddress
  let charburger2: SignerWithAddress
  let lowSimmer1: SignerWithAddress
  let lowSimmer2: SignerWithAddress
  let fairShare1: SignerWithAddress
  let fairShare2: SignerWithAddress
  let undisclosed1: SignerWithAddress
  let undisclosed2: SignerWithAddress

  beforeEach(async () => {
    ({planetaryArsonist1, planetaryArsonist2, charburger1, charburger2, lowSimmer1, lowSimmer2, fairShare1, fairShare2, undisclosed1, undisclosed2} = await setup());

    await deployments.fixture(['gasDAOn']);

    const GasDAOnDeployment: Deployment = await deployments.get('GasDAOn');
    gasDAOn = await Promise.resolve(ethers.getContractAt('GasDAOn', GasDAOnDeployment.address) as Promise<GasDAOn>);
  });


  it('Basic integration: participate, propose, vote', async () => {
    await gasDAOn.connect(planetaryArsonist1).participate(ethers.BigNumber.from('0'));
    await gasDAOn.connect(planetaryArsonist2).participate(ethers.BigNumber.from('0'));
    await gasDAOn.connect(charburger1).participate(ethers.BigNumber.from('1'));
    await gasDAOn.connect(charburger2).participate(ethers.BigNumber.from('1'));
    await gasDAOn.connect(lowSimmer1).participate(ethers.BigNumber.from('2'));
    await gasDAOn.connect(lowSimmer2).participate(ethers.BigNumber.from('2'));
    await gasDAOn.connect(fairShare1).participate(ethers.BigNumber.from('3'));
    await gasDAOn.connect(fairShare2).participate(ethers.BigNumber.from('3'));
    await gasDAOn.connect(undisclosed1).participate(ethers.BigNumber.from('4'));
    await gasDAOn.connect(undisclosed2).participate(ethers.BigNumber.from('4'));

    await gasDAOn.connect(fairShare1).propose("Would the world be better off if people used bicycles instead of cars?  No: 0, Yes: 1");

    await expect(gasDAOn.connect(planetaryArsonist1).vote(
      ethers.BigNumber.from('1'),
      ethers.BigNumber.from('0')
    )).to.emit(gasDAOn, 'Vote')
      .withArgs(
        ethers.BigNumber.from('1'),
        ethers.BigNumber.from('0')
      );

    await expect(gasDAOn.connect(planetaryArsonist2).vote(
      ethers.BigNumber.from('1'),
      ethers.BigNumber.from('0')
    )).to.emit(gasDAOn, 'Vote')
      .withArgs(
        ethers.BigNumber.from('1'),
        ethers.BigNumber.from('0')
      );

    await expect(gasDAOn.connect(charburger1).vote(
      ethers.BigNumber.from('1'),
      ethers.BigNumber.from('0')
    )).to.emit(gasDAOn, 'Vote')
      .withArgs(
        ethers.BigNumber.from('1'),
        ethers.BigNumber.from('0')
      );

    await expect(gasDAOn.connect(charburger2).vote(
      ethers.BigNumber.from('1'),
      ethers.BigNumber.from('0')
    )).to.emit(gasDAOn, 'Vote')
      .withArgs(
        ethers.BigNumber.from('1'),
        ethers.BigNumber.from('0')
      );

    await expect(gasDAOn.connect(lowSimmer1).vote(
      ethers.BigNumber.from('1'),
      ethers.BigNumber.from('0')
    )).to.emit(gasDAOn, 'Vote')
      .withArgs(
        ethers.BigNumber.from('1'),
        ethers.BigNumber.from('0')
      );

    await expect(gasDAOn.connect(lowSimmer2).vote(
      ethers.BigNumber.from('1'),
      ethers.BigNumber.from('0')
    )).to.emit(gasDAOn, 'Vote')
      .withArgs(
        ethers.BigNumber.from('1'),
        ethers.BigNumber.from('0')
      );

    await expect(gasDAOn.connect(fairShare1).vote(
      ethers.BigNumber.from('1'),
      ethers.BigNumber.from('1')
    )).to.emit(gasDAOn, 'Vote')
      .withArgs(
        ethers.BigNumber.from('1'),
        ethers.BigNumber.from('1')
      );

    await expect(gasDAOn.connect(fairShare2).vote(
      ethers.BigNumber.from('1'),
      ethers.BigNumber.from('1')
    )).to.emit(gasDAOn, 'Vote')
      .withArgs(
        ethers.BigNumber.from('1'),
        ethers.BigNumber.from('1')
      );

    await expect(gasDAOn.connect(undisclosed1).vote(
      ethers.BigNumber.from('1'),
      ethers.BigNumber.from('0')
    )).to.emit(gasDAOn, 'Vote')
      .withArgs(
        ethers.BigNumber.from('1'),
        ethers.BigNumber.from('0')
      );

    await expect(gasDAOn.connect(undisclosed2).vote(
      ethers.BigNumber.from('1'),
      ethers.BigNumber.from('0')
    )).to.emit(gasDAOn, 'Vote')
      .withArgs(
        ethers.BigNumber.from('1'),
        ethers.BigNumber.from('0')
      );
  });
});
