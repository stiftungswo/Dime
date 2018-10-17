import {action, observable} from "mobx";
import {Api} from "../api"

interface EmployeeListing{
    id: number;
    email: string;
    first_name: string;
    last_name: string
}

export class EmployeeStore{

    @observable public employees: EmployeeListing[] = []

    constructor(private api: Api){}

    @action public async fetchEmployees(enabled=true){
        const res = await this.api.client.get<EmployeeListing[]>('/employees')
        this.employees = res.data
    }

}