import * as React from 'react';
import { ErrorMessage, FieldProps } from 'formik';
import FormControl from '@material-ui/core/FormControl';
import FormHelperText from '@material-ui/core/FormHelperText';
import InputLabel from '@material-ui/core/InputLabel';
import Input from '@material-ui/core/Input/Input';
import { ReactNode } from 'react';

export type FormProps = { label: string; children: JSX.Element; fullWidth: boolean } & FieldProps;
export type InputFieldProps = { type: string } & FormProps;

export const ValidatedFormGroupWithLabel = ({ label, field, form: { touched, errors }, children, fullWidth }: FormProps) => {
  const hasErrors: boolean = !!errors[field.name] && !!touched[field.name];

  return (
    <FormControl margin={'normal'} error={hasErrors} fullWidth={fullWidth}>
      <InputLabel htmlFor={field.name}>{label}</InputLabel>
      {children}
      <ErrorMessage name={field.name} render={error => <FormHelperText error={true}>{error}</FormHelperText>} />
    </FormControl>
  );
};

export const FieldWithValidation = ({ label, field, type = 'text', form, fullWidth = false }: FormProps & { type: string }) => {
  return (
    <ValidatedFormGroupWithLabel label={label} field={field} form={form} fullWidth={fullWidth}>
      <input {...field} type={type} />
    </ValidatedFormGroupWithLabel>
  );
};

export const InputFieldWithValidation = ({ label, field, form, fullWidth = false, type = 'text' }: InputFieldProps) => (
  <ValidatedFormGroupWithLabel label={label} field={field} form={form} fullWidth={fullWidth}>
    <Input id={field.name} name={field.name} type={type} fullWidth={fullWidth} {...field} />
  </ValidatedFormGroupWithLabel>
);

export const EmailFieldWithValidation = ({ label, field, form, fullWidth = false, children }: FormProps & { children: ReactNode }) => (
  <InputFieldWithValidation type={'email'} label={label} fullWidth={fullWidth} field={field} form={form} children={children} />
);

export const PasswordFieldWithValidation = ({ label, field, form, fullWidth = false, children }: FormProps & { children: ReactNode }) => (
  <InputFieldWithValidation type={'password'} label={label} fullWidth={fullWidth} field={field} form={form} children={children} />
);
