# Resource Audit

Auditing tool for Code Union's curricular, instructional, tooling, and documentation resources.

Code Union stores all resources as repositories in their GitHub organization. Therefore this repository will provide a means for running analysis and generating reports about the current state of those repositories.

## Usage

This repository comes with a small set of utility scripts and a set of manifest files for each codeunion repository.

To use many of them, you will need to set a `GITHUB_ACCESS_TOKEN` environment variable.

Start by copying `.env-example` to a file called `.env` and change the value of `GITHUB_ACCESS_TOKEN` to your own token.

Now you can run the scripts in `/bin`.

### Scripts

**Clone all Code Union repositories**

```shell
./bin/clone-all-repos.sh # will clone them into a `./repos` directory
```

### Manifests

Each repository has its own manifest file in the `./manifests` directory.

Manifest files contain core information about the repository following the [schema](#schema) outlined below.

These manifest files will eventually be ported over to each repository as a `codeunion.json` file. Tools in this repository will then be able to read, analyze, and write to these files on every repository.

For now, the manifest files are divorced from their associated repositories and must be managed independently.

## Schema

Each repository can be identified and categorized according to the following schema rules:

**name**: String<br>
The name of the repository. Must not include organization name.

**category**: String<br>
The category of the repository's primary function. Accepted values: `exercises`, `projects`, `examples`, `guides`, `references`, `tools`, `sites`, `documentation`. See [Category Definitions](/#category-definitions) below.

**description**: String<br>
A brief (2-3) sentence description of what the repository contains.

**tags**: Array[String]<br>
List of identifying keywords for the repository. Must be: (1) languages used, (2) frameworks & libraries used, (3) high-level concepts implemented/explained. Tags must not contain spaces, use dashes instead.

**url**: String<br>
URL of hosted repository on GitHub. Use `https://` protocol.

**access**: Array[String]<br>
List of user types for whom the repository is intended. Accepted values: `staff`, `students`, `public`.

**private**: Boolean<br>
Is the repository publicly visible on GitHub?

**license**: String<br>
File path to the license file for the repository, relative to repository root directory.

## Category Definitions

There are 5 categories for student-facing repositories, 1 category for student-or staff-facing repositories, and 2 categories for staff-facing repositories.

### Student-facing Repositories

1. **Exercises**: short-time-frame, focused, atomic, contrived, highly deterministic coding challenges with explicit, terse, and unambiguous instructions.
2. **Projects**: long-time-frame, multi-faceted, iterative, versioned, real-world-simulating software projects with clearly defined use cases and non-deterministic implementation strategies.
3. **Examples**: feature-complete, well-documented source code repositories for a project with richly descriptive commit histories following a one-branch-per-feature git merge workflow.
4. **Guides**: objective-oriented instructional materials to aid students in accomplishing specific tasks.
5. **References**: explanatory, task-agnostic, concept-oriented instructional materials to build understanding of specific concepts.

### Student- or Staff-facing Repositories

1. **Tools**: executable or template source code to accomplish administrative, instructional, or learning tasks.

### Staff-facing Repositories

1. **Sites**: world wide websites, usually subdomains of `codeunion.io`
2. **Docs**: staff's internal references and guides for administrative and instructional duties.
