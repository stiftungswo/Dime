import {observable} from "mobx";
import {AxiosInstance} from "axios";
import {Service} from "../types";

interface ServiceListing{
    id: number;
    name: string;
    shortDescription: string
}

export class ServiceStore{

    @observable public services: ServiceListing[] = []
    @observable public service?: Service = undefined;

    constructor(private api: AxiosInstance){}

    public async fetchServices(){
        const res = await this.api.get<ServiceListing[]>('/services')
        this.services = res.data
    }

    public async fetchService(id: number){
        const res = await this.api.get<Service>('/services/' + id)
        this.service = res.data;
    }
}