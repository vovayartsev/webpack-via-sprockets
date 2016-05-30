import fetchUrl from 'fetch-promise';

class UserApi {
  create(user) {
    return fetchUrl('/users', {method: 'POST', payload: {user: user}});
  }
}

export default UserApi;

