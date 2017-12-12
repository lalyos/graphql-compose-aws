/* @flow */
/* eslint-disable no-console */

import schema from './schema';
import { graphql } from 'graphql';
import getStdin from 'get-stdin';

var variables =  JSON.parse(process.env.GQ_VARIABLES || '{}')

if (process.env.AWS_ACCESS_KEY_ID) {
    variables.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY_ID 
}
if (process.env.AWS_SECRET_ACCESS_KEY) {
    variables.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_ACCESS_KEY 
}
if (process.env.AWS_DEFAULT_REGION) {
    variables.AWS_DEFAULT_REGION = process.env.AWS_DEFAULT_REGION 
}
getStdin().then(str => {
    //console.log(str);
    graphql(schema, str, null, null, variables).then((response) => {
    console.log(JSON.stringify(response));
  }).catch(error => {
    console.log(error)
});

});

