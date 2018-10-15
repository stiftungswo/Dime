import {action, observable} from "mobx";
import {AxiosInstance} from "axios";

interface EmployeeListing{
    id: number;
    email: string;
    firstname: string;
    lastname: string
}

export class EmployeeStore{

    @observable public employees: EmployeeListing[] = []

    constructor(private api: AxiosInstance){}

    @action public async fetchEmployees(enabled=true){
        const res = await this.api.get<EmployeeListing[]>('/employees?enabled=1')
        this.employees = res.data
    }

}