import {computed, runInAction} from "mobx";
import {Api} from "./api";

interface JwtToken {
    token: string
}

export class AuthStore {
    constructor(private api: Api){}

    public async postLogin(values: {email: string, password: string}){
        const { email, password } = values
        const res = await this.api.client.post<JwtToken>('employees/login', {
            email, password
        })
        runInAction(()=>{
            this.api.token = res.data.token;
        })
    }

    @computed public get isLoggedIn(){
        return !!this.api.token
    }

    @computed public get isAdmin(){
        //TODO decode jwt
        return false;
    }
}
