import { Vec3 } from '@aquiversdk/shared';
import { SharedConfig } from '../../../../shared/shared-config';
import { TSL } from '../../../../shared/shared-translations';
import { FarmDatabaseInterface } from '../../../../shared/shared-types';

import * as sdk from '../client';

export class AnimalFarm {
    blip: number;
    enterdoor: sdk.AquiverDoor;
    exitdoor: sdk.AquiverDoor;

    constructor(public _data: FarmDatabaseInterface) {
        /*
        this.blip = AddBlipForCoord(this.position.x, this.position.y, this.position.z);
        SetBlipSprite(this.blip, 85);
        SetBlipDisplay(this.blip, 4);
        SetBlipScale(this.blip, 1.0);
        SetBlipColour(this.blip, 4);
        SetBlipAsShortRange(this.blip, true);
        BeginTextCommandSetBlipName('STRING');
        AddTextComponentString(this.name);
        EndTextCommandSetBlipName(this.blip);
        */

        this.updateDoor();
    }
    updateDoor() {
        if (!this.enterdoor) {
            this.enterdoor = sdk.DoorManager.new({
                pos: this.position,
                text: '',
                dimension: SharedConfig.DimensionManager.DefaultDimension,
                entercallback: () => {
                    TriggerServerEvent('farm-enter', this.farmId);
                },
                lockcallback: () => {
                    TriggerServerEvent('farm-lock', this.farmId);
                },
                buymenucallback: () => {
                    TriggerServerEvent('farm-open-buymenu', this.farmId);
                },
            });
        }
        if (!this.exitdoor) {
            this.exitdoor = sdk.DoorManager.new({
                pos: SharedConfig.AnimalFarm.InteriorPosition,
                text: '',
                dimension: this.farmId,
                entercallback: () => {
                    TriggerServerEvent('farm-exit', this.farmId);
                },
                lockcallback: () => {
                    TriggerServerEvent('farm-lock', this.farmId);
                },
                buymenucallback: () => {
                    TriggerServerEvent('farm-open-buymenu', this.farmId);
                },
            });
        }

        let exit_text = '';
        exit_text += `${TSL.list.exit_text}\n`;
        exit_text += `~s~#${this.farmId}\n`;
        exit_text += `${this.name}`;

        this.exitdoor.text = exit_text;

        let enter_text = '';
        if (this.isOwned()) {
            enter_text += `#${this.farmId}\n`;
            enter_text += `${this.name}`;
        } else {
            enter_text += `${TSL.list.sell_text}\n`;
            enter_text += `~s~#${this.farmId}\n`;
            enter_text += `${this.name}\n`;
            enter_text += `${TSL.list.price}: $${this.price}`;
        }

        this.enterdoor.text = enter_text;
    }
    isOwned() {
        return this.ownerIdentifier ? true : false;
    }
    get farmId() {
        return this._data.farmId;
    }
    get ownerIdentifier() {
        return this._data.ownerIdentifier;
    }
    set ownerIdentifier(identifier: string) {
        this._data.ownerIdentifier = identifier;
        this.updateDoor();
    }
    get ownerName() {
        return this._data.ownerName;
    }
    set ownerName(str: string) {
        this._data.ownerName = str;
        this.updateDoor();
    }
    get img() {
        return this._data.img;
    }
    set img(url: string) {
        this._data.img = url;
    }
    get name() {
        return this._data.name;
    }
    set name(str: string) {
        this._data.name = str;
        this.updateDoor();
    }
    get price() {
        return this._data.price;
    }
    set price(amount: number) {
        this._data.price = amount;
        this.updateDoor();
    }
    get locked() {
        return this._data.locked;
    }
    set locked(state: boolean) {
        this._data.locked = state;
    }
    get position() {
        return new Vec3(this._data.x, this._data.y, this._data.z);
    }
    set position(v3: Vec3) {
        this._data.x = v3.x;
        this._data.y = v3.y;
        this._data.z = v3.z;

        if (DoesBlipExist(this.blip)) SetBlipCoords(this.blip, v3.x, v3.y, v3.z);
        if (this.enterdoor) this.enterdoor.position = v3;
    }
}

export const FarmManager = new (class {
    ClientFarms = new Map<number, AnimalFarm>();

    constructor() {
        onNet('load-farm', (data: FarmDatabaseInterface) => {
            this.ClientFarms.set(data.farmId, new AnimalFarm(data));
        });
        onNet('farm-update-data', (id: number, key: string, value: any) => {
            const Farm = this.at(id);
            Farm && (Farm[key] = value);
        });
    }
    at(x: number | AnimalFarm) {
        if (typeof x === 'number') return this.ClientFarms.get(x);
        else if (x instanceof AnimalFarm) {
            for (let v of this.ClientFarms.values()) {
                if (v == x) return v;
            }
        }
    }
    exist(x: number | AnimalFarm) {
        if (typeof x === 'number') return this.ClientFarms.has(x);
        else if (x instanceof AnimalFarm) {
            for (let v of this.ClientFarms.values()) {
                if (v == x) return true;
            }
        }
    }
})();
