/* @flow */
/* eslint-disable no-console */

import schema from './schema';
import { graphql } from 'graphql';
import getStdin from 'get-stdin';

 var variables =  JSON.parse(process.env.GQ_VARIABLES || '{}')

getStdin().then(str => {
    //console.log(str);
    graphql(schema, str, null, null, variables).then((response) => {
    console.log(JSON.stringify(response));
  }).catch(error => {
    console.log(error)
});

});

