import {action, observable} from "mobx";
import {Api} from "../api"

interface EmployeeListing{
    id: number;
    email: string;
    firstname: string;
    lastname: string
}

export class EmployeeStore{

    @observable public employees: EmployeeListing[] = []

    constructor(private api: Api){}

    @action public async fetchEmployees(enabled=true){
        const res = await this.api.client.get<EmployeeListing[]>('/employees?enabled=1')
        this.employees = res.data
    }

}