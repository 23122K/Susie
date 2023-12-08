//
//  LocalizedStringResource+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 03/12/2023.
//

import Foundation
import SwiftUI

extension LocalizedStringResource {
    struct Localized {
        //MARK: - Common
        var save: LocalizedStringResource {
            LocalizedStringResource("save", defaultValue: "Save", comment: "e.g. save current status")
        }
        
        var cancel: LocalizedStringResource {
            LocalizedStringResource("cancel", defaultValue: "Cancel", comment: "e.g. cancel registration process")
        }
        
        var dissmis: LocalizedStringResource {
            LocalizedStringResource("dismiss", defaultValue: "Dismiss", comment: "e.g. dismiss some object")
        }
        
        var close: LocalizedStringResource {
            LocalizedStringResource("close", defaultValue: "Close", comment: "e.g. close some view")
        }
        
        var edit: LocalizedStringResource {
            LocalizedStringResource("edit", defaultValue: "Edit", comment: "e.g. edit comment")
        }
        
        var delete: LocalizedStringResource {
            LocalizedStringResource("delete", defaultValue: "Delete", comment: "e.g delete some object")
        }
        
        var details: LocalizedStringResource {
            LocalizedStringResource("deatils", defaultValue: "Details", comment: "e.g additional information")
        }
        
        var signIn: LocalizedStringResource {
            LocalizedStringResource("signIn", defaultValue: "Sign in", comment: "e.g sign in to your accout")
        }
        
        var signUp: LocalizedStringResource {
            LocalizedStringResource("signUp", defaultValue: "Sign up", comment: "e.g create new accout")
        }
        
        var signOut: LocalizedStringResource {
            LocalizedStringResource("signOut", defaultValue: "Sign out", comment: "e.g log out of your accout ")
        }
        
        var account: LocalizedStringResource {
            LocalizedStringResource("account", defaultValue: "Account", comment: "e.g. bank account")
        }
        
        var next: LocalizedStringResource {
            LocalizedStringResource("next", defaultValue: "Next", comment: "e.g. continue to next step when filling the forms")
        }
        
        var logInToSusie: LocalizedStringResource {
            LocalizedStringResource("logInToSusie", defaultValue: "Log in to Susie", comment: "e.g. log in to Susie application")
        }
        
        var createPassword: LocalizedStringResource {
            LocalizedStringResource("createPassword", defaultValue: "Create password", comment: "e.g. shown when user creates password")
        }
        
        var letsGetStarted: LocalizedStringResource {
            LocalizedStringResource("letsGetStarted", defaultValue: "Let's get started", comment: "e.g. encourage user to try out our service")
        }
        
        var fullTermsOfServiceAndPrivacyPolies: LocalizedStringResource {
            LocalizedStringResource("fullTermsOfServiceAndPrivacyPolies", defaultValue: "By signing up, you agree to our Terms of Service and Privacy policies")
        }
        
        var privacyPolicies: LocalizedStringResource {
            LocalizedStringResource("privacyPolicies", defaultValue: "Privacy Policies", comment: "must match words used in fullTermsOfServiceAndPrivacyPolies key")
        }
        
        var termsOfService: LocalizedStringResource {
            LocalizedStringResource("termsOfService", defaultValue: "Terms of Service", comment: "must match words used in fullTermsOfServiceAndPrivacyPolies key")
        }
        
        var susie: LocalizedStringResource {
            LocalizedStringResource("susie", defaultValue: "Susie", comment: "dont translate as its application name")
        }
        
        var description: LocalizedStringResource {
            LocalizedStringResource("description", defaultValue: "Description", comment: "e.g task description")
        }
        
        var projects: LocalizedStringResource {
            LocalizedStringResource("projects", defaultValue: "Projects")
        }
        
        var boards: LocalizedStringResource {
            LocalizedStringResource("boards", defaultValue: "Boards", comment: "Boards are placed above Kanban Board view")
        }
        
        var or: LocalizedStringResource {
            LocalizedStringResource("or", defaultValue: "or", comment: "lowercased; e.g sing up or get started today")
        }
        
        var dashboard: LocalizedStringResource {
            LocalizedStringResource("dashboard", defaultValue: "Dashboard")
        }

        var backlog: LocalizedStringResource {
            LocalizedStringResource("backlog", defaultValue: "Backlog", comment: "dont traslate")
        }
        
        var home: LocalizedStringResource {
            LocalizedStringResource("home", defaultValue: "Home", comment: "dont translate")
        }
        
        //MARK: Forms
        var lastName: LocalizedStringResource {
            LocalizedStringResource("lastName", defaultValue: "Last name", comment: "e.g. person last name")
        }
        
        var fistName: LocalizedStringResource {
            LocalizedStringResource("firstName", defaultValue: "First name", comment: "e.g. person first name")
        }
        
        var email: LocalizedStringResource {
            LocalizedStringResource("email", defaultValue: "Email")
        }
        
        var password: LocalizedStringResource {
            LocalizedStringResource("password", defaultValue: "Password", comment: "e.g. email password")
        }
        
        var confirmPassword: LocalizedStringResource {
            LocalizedStringResource("conrimPassword", defaultValue: "Confirm password", comment: "e.g. retype password for confirmation")
        }
        
        var createYourAccount: LocalizedStringResource {
            LocalizedStringResource("createYourAccount", defaultValue: "Create your account")
        }
        
        var registerAsAScrumMaster: LocalizedStringResource {
            LocalizedStringResource("registerAsAScrumMaster", defaultValue: "Register as a Scrum master")
        }
        
        //MARK: - Sprint
        var start: LocalizedStringResource { 
            LocalizedStringResource("start", defaultValue: "Start", comment: "e.g start some action")
        }
        
        var createSprint: LocalizedStringResource {
            LocalizedStringResource("createSprint", defaultValue: "Create Sprint")
        }
        
        var sprintDescription: LocalizedStringResource { 
            LocalizedStringResource("sprintDescription", defaultValue: "Sprint description")
        }
        
        var newSprint: LocalizedStringResource {
            LocalizedStringResource("newSprint", defaultValue: "New Sprint")
        }
        
        var sprintGoal: LocalizedStringResource {
            LocalizedStringResource("sprintGoal", defaultValue: "Sprint goal", comment: "e.g. what this project aims to solve")
        }
        
        var sprintTitle: LocalizedStringResource {
            LocalizedStringResource("sprintTitle", defaultValue: "Sprint title")
        }
        
        var startDate: LocalizedStringResource {
            LocalizedStringResource("startDate", defaultValue: "Start date", comment: "e.g. Start date")
        }
        
        var stopSprint: LocalizedStringResource {
            LocalizedStringResource("stopSprint", defaultValue: "Stop Sprint")
        }
        
        //MARK: - Project
        var members: LocalizedStringResource {
            LocalizedStringResource("members", defaultValue: "Members", comment: "e.g. team members")
        }
        
        var projectTitle: LocalizedStringResource {
            LocalizedStringResource("projectTitle", defaultValue: "Project title")
        }
        
        var createProject: LocalizedStringResource { 
            LocalizedStringResource("createProject", defaultValue: "Create Project")
        }
        
        var projectDescription: LocalizedStringResource {
            LocalizedStringResource("projectDescription", defaultValue: "Project description")
        }
        
        var newProject: LocalizedStringResource {
            LocalizedStringResource("newProject", defaultValue: "New project")
        }
        
        var projectGoal: LocalizedStringResource {
            LocalizedStringResource("projectGoal", defaultValue: "Project goal", comment: "e.g. what this project aims to solve")
        }
        
        var deleteProject: LocalizedStringResource {
            LocalizedStringResource("deleteProject", defaultValue: "Delete project")
        }
        
        var editProject: LocalizedStringResource {
            LocalizedStringResource("editProject", defaultValue: "Edit project")
        }
    
        var addNewMember: LocalizedStringResource {
            LocalizedStringResource("addNewMember", defaultValue: "Add new member", comment: "e.g add new member to a team")
        }
        
        var invite: LocalizedStringResource {
            LocalizedStringResource("invite", defaultValue: "Invite", comment: "e.g invite new member to a team")
        }
        
        
        //MARK: - Comments
        var comments: LocalizedStringResource {
            LocalizedStringResource("comments", defaultValue: "Comments", comment: "e.g comments posted under post")
        }
        
        var addComment: LocalizedStringResource {
            LocalizedStringResource("addComment", defaultValue: "Add comment...")
        }
        
        
        //MARK: - Issue
        var issueTitle: LocalizedStringResource {
            LocalizedStringResource("issueTitle", defaultValue: "Issue title", comment: "title of some task")
        }
        
        var issuePriority: LocalizedStringResource {
            LocalizedStringResource("issuePriority", defaultValue: "Issue priority")
        }
        
        var issueEstimation: LocalizedStringResource {
            LocalizedStringResource("issueEstimation", defaultValue: "Issue estimation")
        }
        
        var createIssue: LocalizedStringResource {
            LocalizedStringResource("createIssue", defaultValue: "Create issue")
        }
        
        var issueType: LocalizedStringResource {
            LocalizedStringResource("issueType", defaultValue: "Issue type")
        }
        
        var asignee: LocalizedStringResource {
            LocalizedStringResource("asignee", defaultValue: "Asignee", comment: "person assigned to given task")
        }
        
        var unassigned: LocalizedStringResource {
            LocalizedStringResource("unassigned", defaultValue: "Unassigned", comment: "this object has noone assigned to it")
        }
        
        var myIssues: LocalizedStringResource {
            LocalizedStringResource("myIssues", defaultValue: "My issues")
        }
        
        //MARK: Definition of Done
        
        var definitionOfDone: LocalizedStringResource {
            LocalizedStringResource("definitionOfDone", defaultValue: "Definition of done")
        }
    }
    
    static let localized = Localized()
    
    var asString: String {
        String(localized: self)
    }
}

