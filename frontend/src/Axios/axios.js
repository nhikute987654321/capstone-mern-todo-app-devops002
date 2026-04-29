import axios from "axios"
const instance = axios.create({
   baseURL:"http://node.techdigital.online/api"
})
export default instance