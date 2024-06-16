import http from '@ohos.net.http';

export function httpRequestGet(url: string) {
  return new Promise(async (resolve: Function, reject: Function) => {
    http.createHttp().request(url)
      .then((response: http.HttpResponse) => resolve(JSON.parse(response.result as string)))
      .catch(() => reject());
  })
}
