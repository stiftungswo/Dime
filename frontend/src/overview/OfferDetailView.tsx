import {inject, observer} from "mobx-react";
import * as React from "react";
import {OfferStore} from "../store/offerStore";
import {Offer, OfferPosition} from "../types";
import {RouteComponentProps} from "react-router";
import {Field, FieldArray, Formik} from "formik";
import * as yup from "yup";
import {FieldWithValidation} from "../form/common";
import {EmployeeSelector} from "../form/EmployeeSelector";
import {ServiceStore} from "../store/serviceStore";
import {Fragment} from 'react';
import {ServiceSelector} from "../form/ServiceSelector";

interface OfferDetailRouterProps {
    id?: string;
}

export interface Props extends RouteComponentProps<OfferDetailRouterProps> {
    offerStore?: OfferStore;
    serviceStore?: ServiceStore;
}

const offerSchema = yup.object({
    name: yup.string().required(),
    accountantId: yup.number().required(),
    offerPositions: yup.array(yup.object({
        id: yup.number().nullable(true),
        amount: yup.number().required(),
        rateValue: yup.number().required(),
        service: yup.object({
            id: yup.number().required(),
        })
    }))
})

function findById(list: {id: number}[], id: number): any{
    return list.filter(x => x.id === Number(id))[0] || {};
}

const offerPositionTemplate = {
    id: null,
    amount: 0,
    rateValue: 0,
    service: {
        id: ""
    }
}

@inject((stores: any) => ({
    offerStore: stores.offerStore as OfferStore,
    serviceStore: stores.serviceStore as ServiceStore
}))
@observer
export default class OfferDetailView extends React.Component<Props>{
    constructor(props: Props){
        super(props);
        props.offerStore!.fetchOffer(Number(props.match.params.id));
        props.serviceStore!.fetchServices();
    }
    public render() {
        const offer: Offer|undefined = this.props!.offerStore!.offer;
        if(offer){
            return (
                <Formik
                    validationSchema={offerSchema}
                    initialValues={{
                        ...offer,
                        accountantId: offer.accountant ? offer.accountant.id : null
                    }}
                    onSubmit={console.log}
                    render={(props)=>(
                    <form onSubmit={props.handleSubmit}>
                        <Field component={FieldWithValidation} name="name" label="Name"/>
                        <Field component={EmployeeSelector} name="accountantId" label="Verantwortlicher Mitarbeiter"/>
                        <FieldArray name="offerPositions" render={arrayHelpers=>(
                            <div>
                                <h3>Services</h3>
                                <hr/>
                                {props.values.offerPositions.map((p: OfferPosition, index: number) => (
                                    <Fragment key={index}>
                                        <h4>{findById(this.props.serviceStore!.services, props.values.offerPositions[index].service.id).name}</h4>
                                        <Field component={ServiceSelector} name={`offerPositions.${index}.service.id`}  label="Service"/>
                                        <Field component={FieldWithValidation} type="number" name={`offerPositions.${index}.rateValue`} label="Tarif"/>
                                        <Field component={FieldWithValidation} type="number" name={`offerPositions.${index}.amount`} label="Anzahl"/>
                                        <hr/>
                                    </Fragment>
                                ))}
                                <button type="button" onClick={()=>arrayHelpers.push(offerPositionTemplate)}>ANOTHER ONE</button>
                            </div>

                        )}/>
                        <button type="submit">Submit</button>
                    </form>
                )}/>

            )


        } else {
            return <p>Loading...</p>
        }
    }
}

