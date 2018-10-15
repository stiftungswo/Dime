import * as React from "react";
import {EmployeeStore} from "../store/employeeStore";
import {FormProps, ValidatedFormGroupWithLabel} from "./common";
import {inject, observer} from "mobx-react";

interface Props extends FormProps{
    employeeStore?: EmployeeStore
}

@inject("employeeStore")
@observer
export class EmployeeSelector extends React.Component<Props>{
    constructor(props: Props){
        super(props)
        props.employeeStore!.fetchEmployees(true)
    }

    public render(){
        return (
            <ValidatedFormGroupWithLabel label={this.props.label} field={this.props.field} form={this.props.form}>
                <select {...this.props.field}>
                    {this.props.employeeStore!.employees.map(e => (
                        <option key={e.id} value={e.id}>{e.firstname} {e.lastname}</option>
                    ))}
                </select>
            </ValidatedFormGroupWithLabel>
        )
    }

}


