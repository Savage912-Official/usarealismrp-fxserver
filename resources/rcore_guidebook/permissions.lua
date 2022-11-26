PermissionMap = {
    ['group.admin'] = {
        Permissions.OPEN_CONTROL,
        Permissions.EDIT_PAGE,
        Permissions.CREATE_PAGE,
        Permissions.DELETE_PAGE,
        Permissions.CREATE_CATEGORY,
        Permissions.EDIT_CATEGORY,
        Permissions.DELETE_CATEGORY,
        Permissions.CREATE_POINT,
        Permissions.EDIT_POINT,
        Permissions.DELETE_POINT,
        Permissions.SEND_HELP,
        Permissions.TELEPORT,
    },
    ['builtin.everyone'] = { --Everyone
        Permissions.OPEN_PAGE,
        Permissions.NAVIGATE,
    }
}
