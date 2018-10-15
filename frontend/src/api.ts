import axios from 'axios';

// this will be replaced by a build script, if necessary
const baseUrlOverride = 'BASE_URL';
const BASE_URL = baseUrlOverride.startsWith('http') ? baseUrlOverride : 'http://localhost:3000/api/v1';

export const api = () => {
    return axios.create({
        baseURL: BASE_URL,
        headers: {
            Authorization: 'Basic ' + window.btoa("admin:admin") //TODO add real auth
        },
    });
};

// export const apiURL = (path, params, auth = false) => {
//     if (auth) {
//         params.token = Auth.getToken();
//     }
//     return axiosBuildURL(BASE_URL + path, params);
// };