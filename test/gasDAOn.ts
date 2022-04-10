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


  it('', async () => {

  });



});
