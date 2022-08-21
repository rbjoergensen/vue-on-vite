import { Users } from '../types/TestTypes.interface';

export const testApi = async (page: number, per_page: number): Promise<Users> => 
    await fetch(`https://reqres.in/api/users?page=${page}&per_page=${per_page}`)
    .then(val => val.json());