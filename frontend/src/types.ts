export interface Offer {
    id:               number;
    user:             Employee;
    createdAt:        string;
    updatedAt:        string;
    subtotal:         string;
    totalVAT:         string;
    totalDiscounts:   string;
    total:            string;
    offerPositions:   OfferPosition[];
    name:             string;
    project:          Project;
    status:           Status;
    rateGroup:        CustomerRateGroup;
    customer:         Customer;
    accountant:       Employee;
    shortDescription: string;
    description:      string;
    offerDiscounts:   any[];
    tags:             any[];
    address:          Address;
}

export interface Employee {
    archived:           boolean
    email:              string;
    can_login:          boolean;
    is_admin:           boolean;
    id:                 number;
    first_name:         string;
    last_name:          string;
    createdAt:          string;
    updatedAt:          string;
    holidays_per_year:  number;
    realTime:           number;
    targetTime:         number;
    extendTimetrack:    boolean;
    workingPeriods:     any[];
    password:           string;
}

export interface Address {
    id:          number;
    street:      string;
    city:        string;
    plz:         number;
    country:     string;
    supplement?: string;
}

export interface Customer {
    id:             number;
    user:           Employee;
    createdAt:      string;
    updatedAt:      string;
    name:           string;
    alias:          string;
    tags:           any[];
    company:        string;
    department:     string;
    fullname:       string;
    salutation:     string;
    rateGroup:      CustomerRateGroup;
    chargeable:     boolean;
    systemCustomer: boolean;
    address:        Address;
    phones:         any[];
}

export interface CustomerRateGroup {
    id:          number;
    user:        Employee;
    createdAt:   string;
    updatedAt:   string;
    description: string;
    name:        RateGroupName;
}

export enum RateGroupName {
    Kanton = "Kanton",
}

export interface OfferPosition {
    id:                  number;
    user:                User;
    createdAt:           string;
    updatedAt:           string;
    serviceRate:         ServiceRate;
    calculatedRateValue: string;
    total:               string;
    calculatedVAT:       string;
    service:             Service;
    order:               number;
    amount:              number;
    rateValue:           string;
    rateUnit:            RateUnit;
    rateUnitType:        RateUnitType;
    vat:                 number;
}

export enum RateUnit {
    CHFH = "CHF/h",
}

export interface RateUnitType {
    id:          ID;
    user:        User;
    createdAt:   string;
    updatedAt:   string;
    name:        RateUnitTypeName;
    doTransform: boolean;
    factor:      number;
    scale:       number;
    roundMode:   number;
    symbol:      ID;
}

export enum ID {
    H = "h",
}

export enum RateUnitTypeName {
    Stunden = "Stunden",
}

export interface User {}

export interface Service {
    id:          number;
    createdAt:   string;
    updatedAt:   string;
    name:        Alias;
    alias:       Alias;
    description: ServiceDescription;
    rates:       any[];
    tags:        any[];
    chargeable:  boolean;
    vat:         number;
    archived:    boolean;
}

export enum Alias {
    Consulting = "consulting",
}

export enum ServiceDescription {
    ThisIsADetailedDescription = "This is a detailed description",
}

export interface ServiceRate {
    id:           number;
    user:         User;
    createdAt:    string;
    updatedAt:    string;
    rateGroup:    ServiceRateRateGroup;
    rateUnit:     RateUnit;
    rateUnitType: RateUnitType;
    service:      User;
    rateValue:    string;
}

export interface ServiceRateRateGroup {
    id:          number;
    user:        User;
    createdAt:   string;
    updatedAt:   string;
    description: string;
    name:        RateGroupName;
}

export interface Project {
    id:                   number;
    createdAt:            string;
    updatedAt:            string;
    currentPrice:         string;
    remainingBudgetPrice: string;
    currentTime:          string;
    remainingBudgetTime:  string;
    budgetTime:           string;
    budgetPrice:          string;
    name:                 string;
    alias:                string;
    startedAt:            string;
    stoppedAt:            string;
    description:          string;
    tags:                 any[];
    chargeable:           boolean;
    activities:           any[];
    invoices:             any[];
    comments:             any[];
    offers:               any[];
    archived:             boolean;
}

export interface Status {
    id:        number;
    createdAt: string;
    updatedAt: string;
    text:      string;
    active:    boolean;
}