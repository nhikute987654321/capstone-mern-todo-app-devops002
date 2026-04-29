import axios from "axios"
const instance = axios.create({
   baseURL:"https://node.techdigital.online/api"
})
export default instance