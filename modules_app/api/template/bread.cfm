<cfscript>
/* *** BREAD template *** */
prc['set'] = {
    'browse': {
        'handler': {
            'handler': 'bread',
            'action': 'browse'
        },
        'route': {
            'endpath': 'end/path',
            'verb': 'GET'
        }
    },
    'read': {
        'handler': {
            'name': 'bread',
            'action': 'read',
            'verb': 'GET'
        },
        'route': {
            'endpath': 'end/path/:id'
        }
    },
    'edit': {
        'handler': {
            'name': 'bread',
            'action': 'edit',
            'verb': 'PUT'
        },
        'route': {
            'endpath': 'end/path/:id'
        }
    },
    'add': {
        'handler': {
            'name': 'bread',
            'action': 'add',
            'verb': 'POST'
        },
        'route': {
            'endpath': 'end/path'
        }
    },
    'delete': {
        'handler': {
            'name': 'bread',
            'action': 'delete',
            'verb': 'DELETE'
        },
        'route': {
            'endpath': 'end/path/:id'
        }
    }
};
/*
group first by handler and then by endpaths
seperate the handler/action matches to the verb for caller
*/
</cfscript>
