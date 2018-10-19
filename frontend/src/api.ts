import axios from 'axios';
import {computed, observable} from "mobx";

// this will be replaced by a build script, if necessary
const baseUrlOverride = 'BASE_URL';
const BASE_URL = baseUrlOverride.startsWith('http') ? baseUrlOverride : 'http://localhost:38000/api/v1';

const KEY_TOKEN = 'dime_token';

export class Api{
    constructor(){
        const token = localStorage.getItem(KEY_TOKEN);
        if(token){
            this._token = token;
        }
    }

    @observable private _token: string = "";

    @computed public get token() { return this._token; };
    public set token(value){
        this._token = value;
        localStorage.setItem(KEY_TOKEN, value);

    }

    @computed public get client(){
        const authHeader = this.token ? {Authorization: 'Bearer ' + this.token} : {}

        return axios.create({
            baseURL: BASE_URL,
            headers: {
                ...authHeader
            },
        })

    }
}

export default new Api();

