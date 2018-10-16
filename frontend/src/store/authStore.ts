import {action, observable} from "mobx";
import {AxiosInstance} from "axios";

interface JwtToken {
    token: string
}

export class AuthStore {
    @observable public token: JwtToken[] = []

    constructor(private api: AxiosInstance){}

    @action public async postLogin(values: {email: string, password: string}){
        const { email, password } = values
        const res = await this.api.post<JwtToken[]>('employees/login', {
            email, password
        })
        this.token = res.data
    }
}
