import {observable} from "mobx";
import {Service} from "../types";
import {MainStore} from "./mainStore"

interface ServiceListing{
    id: number;
    name: string;
    shortDescription: string
}

export class ServiceStore{

    @observable public services: ServiceListing[] = []
    @observable public service?: Service = undefined;

    constructor(private mainStore: MainStore){}

    public async fetchServices(){
        const res = await this.mainStore.api.get<ServiceListing[]>('/services')
        this.services = res.data
    }

    public async fetchService(id: number){
        const res = await this.mainStore.api.get<Service>('/services/' + id)
        this.service = res.data;
    }
}