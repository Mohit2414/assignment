# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License a
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM golang:1.10.0
RUN go get github.com/codegangsta/negroni \
           github.com/gorilla/mux \
           github.com/xyproto/simpleredis
WORKDIR /app
ADD ./main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM scratch
WORKDIR /app
COPY --from=0 /app/main .
COPY ./index.html index.html
COPY ./script.js script.js
COPY ./style.css style.css
CMD ["/app/main"]
EXPOSE 30000
