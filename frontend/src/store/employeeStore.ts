import {action, observable} from "mobx";
import {MainStore} from "./mainStore"
import {Employee} from "../types"

interface EmployeeListing{
    id: number;
    email: string;
    first_name: string;
    last_name: string
}

export class EmployeeStore{

    @observable public employees: EmployeeListing[] = []
    @observable public employee?: Employee = undefined;

    constructor(private mainStore: MainStore){}

    @action public async fetchEmployees(enabled=true){
        const res = await this.mainStore.api.get<EmployeeListing[]>('/employees')
        this.employees = res.data
    }

    @action public async fetchEmployee(id: number) {
        const res = await this.mainStore.api.get<Employee>('/employees/' + id)
        this.employee = res.data
    }

    @action public async postEmployee(employee: Employee) {
        const res = await this.mainStore.api.post('/employees', employee)
        this.employee = res.data;
    }

    @action public async putEmployee(employee: Employee) {
        const res = await this.mainStore.api.put('/employees/' + employee.id, employee)
        this.employee = res.data
    }
}
