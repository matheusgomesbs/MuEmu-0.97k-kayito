AccountLock_Config = {
    Enabled = true,

    Accounts = {
        ["2222"] = {
            Trade = false,
            Drop = false,
            Sell = false,
            PersonalStore = false,
        },

        ["test"] = {
            Trade = false,
            Drop = false,
            Sell = true,
            PersonalStore = false,
        },
    },

    Message = {
        ["Eng"] = {
            [1] = "Your account is blocked for this action",
        },
        ["Por"] = {
            [1] = "Sua conta está bloqueada para essa ação",
        },
        ["Spn"] = {
            [1] = "Sua conta está bloqueada para essa ação",
        },
    }
}