import axios, {AxiosInstance} from 'axios';
import {computed, observable} from "mobx";

// this will be replaced by a build script, if necessary
const baseUrlOverride = 'BASE_URL';
const BASE_URL = baseUrlOverride.startsWith('http') ? baseUrlOverride : 'http://localhost:38000/api/v1';

const KEY_TOKEN = 'dime_token';

function setAuthHeader(client: AxiosInstance, token: string|null){
    client.defaults.headers["Authorization"] = token ? 'Bearer ' + token: "";
}

export class Api{
    constructor(){
        const token = localStorage.getItem(KEY_TOKEN);
        if(token){
            this._token = token;
        }

        this._client = axios.create({
            baseURL: BASE_URL,
        })
        setAuthHeader(this._client, token);

        this._client.interceptors.request.use((config: any)=>{
            this.openRequests += 1;
            return config;
        }, (error: any)=>{
            return Promise.reject(error);
        })

        this._client.interceptors.response.use((response: any)=>{
            this.openRequests -= 1;
            return response;
        }, (error: any)=>{
            this.openRequests -= 1;
            return Promise.reject(error);
        })
    }

    private _client: AxiosInstance;
    @observable private openRequests = 0;
    @observable private _token: string = "";

    @computed public get loading() { return this.openRequests > 0; }

    @computed public get token() { return this._token; };
    public set token(token){
        this._token = token;
        localStorage.setItem(KEY_TOKEN, token);
        setAuthHeader(this._client, token);
    }

    public get client(){ return this._client; }
}

export default new Api();

