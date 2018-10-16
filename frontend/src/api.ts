import axios from 'axios';
import {computed, observable} from "mobx";

// this will be replaced by a build script, if necessary
const baseUrlOverride = 'BASE_URL';
const BASE_URL = baseUrlOverride.startsWith('http') ? baseUrlOverride : 'http://localhost:38000/api/v1';

export class Api{
    @observable public token?: string;

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

