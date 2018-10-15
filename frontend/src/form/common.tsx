import * as React from 'react';
import { ErrorMessage, FieldProps } from 'formik';

export type FormProps = { label: string; children: JSX.Element } & FieldProps;

export const ValidatedFormGroupWithLabel = ({ label, field, form: { touched, errors }, children }: FormProps) => {
  return (
    <p>
      <label>{label}</label>
      {children}
      <ErrorMessage name={field.name} render={error => <span style={{ color: 'red' }}>{error}</span>} />
    </p>
  );
};

export const FieldWithValidation = ({ label, field, type = 'text', form }: FormProps & { type: string }) => {
  return (
    <ValidatedFormGroupWithLabel label={label} field={field} form={form}>
      <input {...field} type={type} />
    </ValidatedFormGroupWithLabel>
  );
};
