<cfscript>
/* *** BREAD template *** */
prc['set'] = {
    'browse': {
        'handler': {
            'name': '#prc.handler.pattern[1]#',
            'action': 'browse',
            'verb': 'GET'
        },
        'route': {
            'endpath': prc.handler.endpath,
            'verb': 'GET'
        }
    },
    'read': {
        'handler': {
            'name': '#prc.handler.pattern[1]#',
            'action': 'read',
            'verb': 'GET'
        },
        'route': {
            'endpath': '#prc.handler.endpath#/:id'
        }
    },
    'edit': {
        'handler': {
            'name': '#prc.handler.pattern[1]#',
            'action': 'edit',
            'verb': 'PUT'
        },
        'route': {
            'endpath': '#prc.handler.endpath#/:id'
        }
    },
    'add': {
        'handler': {
            'name': '#prc.handler.pattern[1]#',
            'action': 'add',
            'verb': 'POST'
        },
        'route': {
            'endpath': prc.handler.endpath
        }
    },
    'delete': {
        'handler': {
            'name': '#prc.handler.pattern[1]#',
            'action': 'delete',
            'verb': 'DELETE'
        },
        'route': {
            'endpath': '#prc.handler.endpath#/:id'
        }
    }
};
/*
group first by handler and then by endpaths
seperate the handler/action matches to the verb for caller
*/
</cfscript>
