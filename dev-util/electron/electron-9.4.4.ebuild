# Copyright 2009-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk vi zh-CN zh-TW"

inherit check-reqs chromium-2 desktop flag-o-matic multilib ninja-utils pax-utils portability python-any-r1 readme.gentoo-r1 toolchain-funcs xdg-utils yarn

# Keep this in sync with DEPS:chromium_version
CHROMIUM_VERSION="83.0.4103.119"
# Keep this in sync with DEPS:node_version
NODE_VERSION="12.14.1"
CHROMIUM_P="chromium-${CHROMIUM_VERSION}"
NODE_P="node-${NODE_VERSION}"

DESCRIPTION="Cross platform application development framework based on web technologies"
HOMEPAGE="https://electronjs.org/"

# grep resolved yarn.lock | sed 's/^[ ]*resolved \"\(.*\)\#.*\"$/\1/g' >> path to ebuild
YARNPKGS="
https://registry.yarnpkg.com/@babel/code-frame/-/code-frame-7.5.5.tgz
https://registry.yarnpkg.com/@babel/highlight/-/highlight-7.5.0.tgz
https://registry.yarnpkg.com/@babel/runtime/-/runtime-7.5.2.tgz
https://registry.yarnpkg.com/@electron/docs-parser/-/docs-parser-0.4.2.tgz
https://registry.yarnpkg.com/@electron/typescript-definitions/-/typescript-definitions-8.6.4.tgz
https://registry.yarnpkg.com/@mrmlnc/readdir-enhanced/-/readdir-enhanced-2.2.1.tgz
https://registry.yarnpkg.com/@nodelib/fs.stat/-/fs.stat-1.1.3.tgz
https://registry.yarnpkg.com/@octokit/auth-app/-/auth-app-2.10.0.tgz
https://registry.yarnpkg.com/@octokit/endpoint/-/endpoint-5.2.1.tgz
https://registry.yarnpkg.com/@octokit/endpoint/-/endpoint-6.0.5.tgz
https://registry.yarnpkg.com/@octokit/request-error/-/request-error-1.0.4.tgz
https://registry.yarnpkg.com/@octokit/request-error/-/request-error-2.0.3.tgz
https://registry.yarnpkg.com/@octokit/request/-/request-4.1.1.tgz
https://registry.yarnpkg.com/@octokit/request/-/request-5.4.10.tgz
https://registry.yarnpkg.com/@octokit/rest/-/rest-16.28.2.tgz
https://registry.yarnpkg.com/@octokit/types/-/types-5.5.0.tgz
https://registry.yarnpkg.com/@primer/octicons/-/octicons-9.1.1.tgz
https://registry.yarnpkg.com/@samverschueren/stream-to-observable/-/stream-to-observable-0.3.0.tgz
https://registry.yarnpkg.com/@types/anymatch/-/anymatch-1.3.1.tgz
https://registry.yarnpkg.com/@types/basic-auth/-/basic-auth-1.1.2.tgz
https://registry.yarnpkg.com/@types/body-parser/-/body-parser-1.17.0.tgz
https://registry.yarnpkg.com/@types/busboy/-/busboy-0.2.3.tgz
https://registry.yarnpkg.com/@types/chai-as-promised/-/chai-as-promised-7.1.0.tgz
https://registry.yarnpkg.com/@types/chai-as-promised/-/chai-as-promised-7.1.1.tgz
https://registry.yarnpkg.com/@types/chai/-/chai-4.1.7.tgz
https://registry.yarnpkg.com/@types/connect/-/connect-3.4.32.tgz
https://registry.yarnpkg.com/@types/dirty-chai/-/dirty-chai-2.0.0.tgz
https://registry.yarnpkg.com/@types/eslint-visitor-keys/-/eslint-visitor-keys-1.0.0.tgz
https://registry.yarnpkg.com/@types/events/-/events-3.0.0.tgz
https://registry.yarnpkg.com/@types/express-serve-static-core/-/express-serve-static-core-4.16.7.tgz
https://registry.yarnpkg.com/@types/express/-/express-4.17.0.tgz
https://registry.yarnpkg.com/@types/fs-extra/-/fs-extra-5.1.0.tgz
https://registry.yarnpkg.com/@types/glob/-/glob-7.1.1.tgz
https://registry.yarnpkg.com/@types/json-schema/-/json-schema-7.0.3.tgz
https://registry.yarnpkg.com/@types/json-schema/-/json-schema-7.0.4.tgz
https://registry.yarnpkg.com/@types/jsonwebtoken/-/jsonwebtoken-8.5.0.tgz
https://registry.yarnpkg.com/@types/linkify-it/-/linkify-it-2.1.0.tgz
https://registry.yarnpkg.com/@types/lru-cache/-/lru-cache-5.1.0.tgz
https://registry.yarnpkg.com/@types/markdown-it/-/markdown-it-0.0.7.tgz
https://registry.yarnpkg.com/@types/mime/-/mime-2.0.1.tgz
https://registry.yarnpkg.com/@types/minimatch/-/minimatch-3.0.3.tgz
https://registry.yarnpkg.com/@types/mocha/-/mocha-5.2.7.tgz
https://registry.yarnpkg.com/@types/node/-/node-11.13.22.tgz
https://registry.yarnpkg.com/@types/node/-/node-12.6.1.tgz
https://registry.yarnpkg.com/@types/node/-/node-14.14.7.tgz
https://registry.yarnpkg.com/@types/normalize-package-data/-/normalize-package-data-2.4.0.tgz
https://registry.yarnpkg.com/@types/range-parser/-/range-parser-1.2.3.tgz
https://registry.yarnpkg.com/@types/rimraf/-/rimraf-3.0.0.tgz
https://registry.yarnpkg.com/@types/semver/-/semver-6.0.1.tgz
https://registry.yarnpkg.com/@types/send/-/send-0.14.5.tgz
https://registry.yarnpkg.com/@types/serve-static/-/serve-static-1.13.2.tgz
https://registry.yarnpkg.com/@types/split/-/split-1.0.0.tgz
https://registry.yarnpkg.com/@types/tapable/-/tapable-1.0.4.tgz
https://registry.yarnpkg.com/@types/temp/-/temp-0.8.34.tgz
https://registry.yarnpkg.com/@types/through/-/through-0.0.29.tgz
https://registry.yarnpkg.com/@types/uglify-js/-/uglify-js-3.0.4.tgz
https://registry.yarnpkg.com/@types/unist/-/unist-2.0.3.tgz
https://registry.yarnpkg.com/@types/uuid/-/uuid-3.4.6.tgz
https://registry.yarnpkg.com/@types/webpack-env/-/webpack-env-1.13.9.tgz
https://registry.yarnpkg.com/@types/webpack/-/webpack-4.4.34.tgz
https://registry.yarnpkg.com/@typescript-eslint/eslint-plugin/-/eslint-plugin-2.6.0.tgz
https://registry.yarnpkg.com/@typescript-eslint/experimental-utils/-/experimental-utils-2.6.0.tgz
https://registry.yarnpkg.com/@typescript-eslint/parser/-/parser-2.6.0.tgz
https://registry.yarnpkg.com/@typescript-eslint/typescript-estree/-/typescript-estree-2.6.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/ast/-/ast-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/floating-point-hex-parser/-/floating-point-hex-parser-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/helper-api-error/-/helper-api-error-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/helper-buffer/-/helper-buffer-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/helper-code-frame/-/helper-code-frame-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/helper-fsm/-/helper-fsm-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/helper-module-context/-/helper-module-context-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/helper-wasm-bytecode/-/helper-wasm-bytecode-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/helper-wasm-section/-/helper-wasm-section-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/ieee754/-/ieee754-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/leb128/-/leb128-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/utf8/-/utf8-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/wasm-edit/-/wasm-edit-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/wasm-gen/-/wasm-gen-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/wasm-opt/-/wasm-opt-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/wasm-parser/-/wasm-parser-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/wast-parser/-/wast-parser-1.9.0.tgz
https://registry.yarnpkg.com/@webassemblyjs/wast-printer/-/wast-printer-1.9.0.tgz
https://registry.yarnpkg.com/@xtuc/ieee754/-/ieee754-1.2.0.tgz
https://registry.yarnpkg.com/@xtuc/long/-/long-4.2.2.tgz
https://registry.yarnpkg.com/abbrev/-/abbrev-1.1.1.tgz
https://registry.yarnpkg.com/accepts/-/accepts-1.3.7.tgz
https://registry.yarnpkg.com/acorn-jsx/-/acorn-jsx-5.1.0.tgz
https://registry.yarnpkg.com/acorn/-/acorn-6.2.0.tgz
https://registry.yarnpkg.com/acorn/-/acorn-6.3.0.tgz
https://registry.yarnpkg.com/acorn/-/acorn-6.4.1.tgz
https://registry.yarnpkg.com/ajv-errors/-/ajv-errors-1.0.1.tgz
https://registry.yarnpkg.com/ajv-keywords/-/ajv-keywords-3.4.1.tgz
https://registry.yarnpkg.com/ajv-keywords/-/ajv-keywords-3.5.0.tgz
https://registry.yarnpkg.com/ajv/-/ajv-6.10.1.tgz
https://registry.yarnpkg.com/ajv/-/ajv-6.10.2.tgz
https://registry.yarnpkg.com/ajv/-/ajv-6.12.2.tgz
https://registry.yarnpkg.com/ansi-escapes/-/ansi-escapes-3.2.0.tgz
https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-2.1.1.tgz
https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-3.0.0.tgz
https://registry.yarnpkg.com/ansi-regex/-/ansi-regex-4.1.0.tgz
https://registry.yarnpkg.com/ansi-styles/-/ansi-styles-2.2.1.tgz
https://registry.yarnpkg.com/ansi-styles/-/ansi-styles-3.2.1.tgz
https://registry.yarnpkg.com/any-observable/-/any-observable-0.3.0.tgz
https://registry.yarnpkg.com/anymatch/-/anymatch-1.3.2.tgz
https://registry.yarnpkg.com/anymatch/-/anymatch-2.0.0.tgz
https://registry.yarnpkg.com/anymatch/-/anymatch-3.0.3.tgz
https://registry.yarnpkg.com/anymatch/-/anymatch-3.1.1.tgz
https://registry.yarnpkg.com/aproba/-/aproba-1.2.0.tgz
https://registry.yarnpkg.com/are-we-there-yet/-/are-we-there-yet-1.1.5.tgz
https://registry.yarnpkg.com/argparse/-/argparse-1.0.10.tgz
https://registry.yarnpkg.com/arr-diff/-/arr-diff-2.0.0.tgz
https://registry.yarnpkg.com/arr-diff/-/arr-diff-4.0.0.tgz
https://registry.yarnpkg.com/arr-flatten/-/arr-flatten-1.1.0.tgz
https://registry.yarnpkg.com/arr-union/-/arr-union-3.1.0.tgz
https://registry.yarnpkg.com/array-find-index/-/array-find-index-1.0.2.tgz
https://registry.yarnpkg.com/array-flatten/-/array-flatten-1.1.1.tgz
https://registry.yarnpkg.com/array-includes/-/array-includes-3.0.3.tgz
https://registry.yarnpkg.com/array-union/-/array-union-1.0.2.tgz
https://registry.yarnpkg.com/array-uniq/-/array-uniq-1.0.3.tgz
https://registry.yarnpkg.com/array-unique/-/array-unique-0.2.1.tgz
https://registry.yarnpkg.com/array-unique/-/array-unique-0.3.2.tgz
https://registry.yarnpkg.com/arrify/-/arrify-1.0.1.tgz
https://registry.yarnpkg.com/asar/-/asar-1.0.0.tgz
https://registry.yarnpkg.com/asn1.js/-/asn1.js-4.10.1.tgz
https://registry.yarnpkg.com/asn1/-/asn1-0.2.4.tgz
https://registry.yarnpkg.com/assert-plus/-/assert-plus-1.0.0.tgz
https://registry.yarnpkg.com/assert/-/assert-1.5.0.tgz
https://registry.yarnpkg.com/assertion-error/-/assertion-error-1.1.0.tgz
https://registry.yarnpkg.com/assign-symbols/-/assign-symbols-1.0.0.tgz
https://registry.yarnpkg.com/astral-regex/-/astral-regex-1.0.0.tgz
https://registry.yarnpkg.com/async-each/-/async-each-1.0.3.tgz
https://registry.yarnpkg.com/asynckit/-/asynckit-0.4.0.tgz
https://registry.yarnpkg.com/atob-lite/-/atob-lite-2.0.0.tgz
https://registry.yarnpkg.com/atob/-/atob-2.1.2.tgz
https://registry.yarnpkg.com/aws-sign2/-/aws-sign2-0.7.0.tgz
https://registry.yarnpkg.com/aws4/-/aws4-1.8.0.tgz
https://registry.yarnpkg.com/babel-code-frame/-/babel-code-frame-6.26.0.tgz
https://registry.yarnpkg.com/bail/-/bail-1.0.4.tgz
https://registry.yarnpkg.com/balanced-match/-/balanced-match-1.0.0.tgz
https://registry.yarnpkg.com/base/-/base-0.11.2.tgz
https://registry.yarnpkg.com/base64-js/-/base64-js-1.3.0.tgz
https://registry.yarnpkg.com/bcrypt-pbkdf/-/bcrypt-pbkdf-1.0.2.tgz
https://registry.yarnpkg.com/before-after-hook/-/before-after-hook-1.4.0.tgz
https://registry.yarnpkg.com/big.js/-/big.js-5.2.2.tgz
https://registry.yarnpkg.com/binary-extensions/-/binary-extensions-1.13.1.tgz
https://registry.yarnpkg.com/binary-extensions/-/binary-extensions-2.0.0.tgz
https://registry.yarnpkg.com/bl/-/bl-1.2.2.tgz
https://registry.yarnpkg.com/bluebird/-/bluebird-3.5.5.tgz
https://registry.yarnpkg.com/bn.js/-/bn.js-4.11.8.tgz
https://registry.yarnpkg.com/body-parser/-/body-parser-1.19.0.tgz
https://registry.yarnpkg.com/brace-expansion/-/brace-expansion-1.1.11.tgz
https://registry.yarnpkg.com/braces/-/braces-1.8.5.tgz
https://registry.yarnpkg.com/braces/-/braces-2.3.2.tgz
https://registry.yarnpkg.com/braces/-/braces-3.0.2.tgz
https://registry.yarnpkg.com/brorand/-/brorand-1.1.0.tgz
https://registry.yarnpkg.com/browserify-aes/-/browserify-aes-1.2.0.tgz
https://registry.yarnpkg.com/browserify-cipher/-/browserify-cipher-1.0.1.tgz
https://registry.yarnpkg.com/browserify-des/-/browserify-des-1.0.2.tgz
https://registry.yarnpkg.com/browserify-rsa/-/browserify-rsa-4.0.1.tgz
https://registry.yarnpkg.com/browserify-sign/-/browserify-sign-4.0.4.tgz
https://registry.yarnpkg.com/browserify-zlib/-/browserify-zlib-0.1.4.tgz
https://registry.yarnpkg.com/browserify-zlib/-/browserify-zlib-0.2.0.tgz
https://registry.yarnpkg.com/btoa-lite/-/btoa-lite-1.0.0.tgz
https://registry.yarnpkg.com/buffer-alloc-unsafe/-/buffer-alloc-unsafe-1.1.0.tgz
https://registry.yarnpkg.com/buffer-alloc/-/buffer-alloc-1.2.0.tgz
https://registry.yarnpkg.com/buffer-equal-constant-time/-/buffer-equal-constant-time-1.0.1.tgz
https://registry.yarnpkg.com/buffer-fill/-/buffer-fill-1.0.0.tgz
https://registry.yarnpkg.com/buffer-from/-/buffer-from-1.1.1.tgz
https://registry.yarnpkg.com/buffer-xor/-/buffer-xor-1.0.3.tgz
https://registry.yarnpkg.com/buffer/-/buffer-4.9.1.tgz
https://registry.yarnpkg.com/builtin-status-codes/-/builtin-status-codes-3.0.0.tgz
https://registry.yarnpkg.com/bytes/-/bytes-3.1.0.tgz
https://registry.yarnpkg.com/cacache/-/cacache-12.0.4.tgz
https://registry.yarnpkg.com/cache-base/-/cache-base-1.0.1.tgz
https://registry.yarnpkg.com/call-me-maybe/-/call-me-maybe-1.0.1.tgz
https://registry.yarnpkg.com/caller-callsite/-/caller-callsite-2.0.0.tgz
https://registry.yarnpkg.com/caller-path/-/caller-path-0.1.0.tgz
https://registry.yarnpkg.com/caller-path/-/caller-path-2.0.0.tgz
https://registry.yarnpkg.com/callsites/-/callsites-0.2.0.tgz
https://registry.yarnpkg.com/callsites/-/callsites-2.0.0.tgz
https://registry.yarnpkg.com/callsites/-/callsites-3.1.0.tgz
https://registry.yarnpkg.com/camelcase-keys/-/camelcase-keys-2.1.0.tgz
https://registry.yarnpkg.com/camelcase/-/camelcase-2.1.1.tgz
https://registry.yarnpkg.com/camelcase/-/camelcase-4.1.0.tgz
https://registry.yarnpkg.com/camelcase/-/camelcase-5.3.1.tgz
https://registry.yarnpkg.com/capture-stack-trace/-/capture-stack-trace-1.0.1.tgz
https://registry.yarnpkg.com/caseless/-/caseless-0.12.0.tgz
https://registry.yarnpkg.com/ccount/-/ccount-1.0.4.tgz
https://registry.yarnpkg.com/chai/-/chai-4.2.0.tgz
https://registry.yarnpkg.com/chalk/-/chalk-1.1.3.tgz
https://registry.yarnpkg.com/chalk/-/chalk-2.4.2.tgz
https://registry.yarnpkg.com/character-entities-html4/-/character-entities-html4-1.1.3.tgz
https://registry.yarnpkg.com/character-entities-legacy/-/character-entities-legacy-1.1.3.tgz
https://registry.yarnpkg.com/character-entities/-/character-entities-1.2.3.tgz
https://registry.yarnpkg.com/character-reference-invalid/-/character-reference-invalid-1.1.3.tgz
https://registry.yarnpkg.com/chardet/-/chardet-0.4.2.tgz
https://registry.yarnpkg.com/chardet/-/chardet-0.7.0.tgz
https://registry.yarnpkg.com/check-error/-/check-error-1.0.2.tgz
https://registry.yarnpkg.com/check-for-leaks/-/check-for-leaks-1.2.1.tgz
https://registry.yarnpkg.com/checksum/-/checksum-0.1.1.tgz
https://registry.yarnpkg.com/chokidar/-/chokidar-1.7.0.tgz
https://registry.yarnpkg.com/chokidar/-/chokidar-2.1.8.tgz
https://registry.yarnpkg.com/chokidar/-/chokidar-3.4.0.tgz
https://registry.yarnpkg.com/chownr/-/chownr-1.1.2.tgz
https://registry.yarnpkg.com/chownr/-/chownr-1.1.3.tgz
https://registry.yarnpkg.com/chrome-trace-event/-/chrome-trace-event-1.0.2.tgz
https://registry.yarnpkg.com/chromium-pickle-js/-/chromium-pickle-js-0.2.0.tgz
https://registry.yarnpkg.com/ci-info/-/ci-info-2.0.0.tgz
https://registry.yarnpkg.com/cipher-base/-/cipher-base-1.0.4.tgz
https://registry.yarnpkg.com/circular-json/-/circular-json-0.3.3.tgz
https://registry.yarnpkg.com/class-utils/-/class-utils-0.3.6.tgz
https://registry.yarnpkg.com/cli-cursor/-/cli-cursor-1.0.2.tgz
https://registry.yarnpkg.com/cli-cursor/-/cli-cursor-2.1.0.tgz
https://registry.yarnpkg.com/cli-spinners/-/cli-spinners-0.1.2.tgz
https://registry.yarnpkg.com/cli-spinners/-/cli-spinners-2.2.0.tgz
https://registry.yarnpkg.com/cli-truncate/-/cli-truncate-0.2.1.tgz
https://registry.yarnpkg.com/cli-width/-/cli-width-2.2.0.tgz
https://registry.yarnpkg.com/cliui/-/cliui-5.0.0.tgz
https://registry.yarnpkg.com/clone/-/clone-1.0.4.tgz
https://registry.yarnpkg.com/co/-/co-3.1.0.tgz
https://registry.yarnpkg.com/code-point-at/-/code-point-at-1.1.0.tgz
https://registry.yarnpkg.com/collapse-white-space/-/collapse-white-space-1.0.5.tgz
https://registry.yarnpkg.com/collection-visit/-/collection-visit-1.0.0.tgz
https://registry.yarnpkg.com/color-convert/-/color-convert-1.9.3.tgz
https://registry.yarnpkg.com/color-name/-/color-name-1.1.3.tgz
https://registry.yarnpkg.com/colors/-/colors-1.3.3.tgz
https://registry.yarnpkg.com/combined-stream/-/combined-stream-1.0.8.tgz
https://registry.yarnpkg.com/commander/-/commander-2.20.0.tgz
https://registry.yarnpkg.com/commondir/-/commondir-1.0.1.tgz
https://registry.yarnpkg.com/component-emitter/-/component-emitter-1.3.0.tgz
https://registry.yarnpkg.com/concat-map/-/concat-map-0.0.1.tgz
https://registry.yarnpkg.com/concat-stream/-/concat-stream-1.6.2.tgz
https://registry.yarnpkg.com/console-browserify/-/console-browserify-1.1.0.tgz
https://registry.yarnpkg.com/console-control-strings/-/console-control-strings-1.1.0.tgz
https://registry.yarnpkg.com/constants-browserify/-/constants-browserify-1.0.0.tgz
https://registry.yarnpkg.com/contains-path/-/contains-path-0.1.0.tgz
https://registry.yarnpkg.com/content-disposition/-/content-disposition-0.5.3.tgz
https://registry.yarnpkg.com/content-type/-/content-type-1.0.4.tgz
https://registry.yarnpkg.com/cookie-signature/-/cookie-signature-1.0.6.tgz
https://registry.yarnpkg.com/cookie/-/cookie-0.4.0.tgz
https://registry.yarnpkg.com/copy-concurrently/-/copy-concurrently-1.0.5.tgz
https://registry.yarnpkg.com/copy-descriptor/-/copy-descriptor-0.1.1.tgz
https://registry.yarnpkg.com/core-util-is/-/core-util-is-1.0.2.tgz
https://registry.yarnpkg.com/cosmiconfig/-/cosmiconfig-5.2.1.tgz
https://registry.yarnpkg.com/create-ecdh/-/create-ecdh-4.0.3.tgz
https://registry.yarnpkg.com/create-error-class/-/create-error-class-3.0.2.tgz
https://registry.yarnpkg.com/create-hash/-/create-hash-1.2.0.tgz
https://registry.yarnpkg.com/create-hmac/-/create-hmac-1.1.7.tgz
https://registry.yarnpkg.com/cross-spawn/-/cross-spawn-6.0.5.tgz
https://registry.yarnpkg.com/crypto-browserify/-/crypto-browserify-3.12.0.tgz
https://registry.yarnpkg.com/cuint/-/cuint-0.2.2.tgz
https://registry.yarnpkg.com/currently-unhandled/-/currently-unhandled-0.4.1.tgz
https://registry.yarnpkg.com/cyclist/-/cyclist-0.2.2.tgz
https://registry.yarnpkg.com/dashdash/-/dashdash-1.14.1.tgz
https://registry.yarnpkg.com/date-fns/-/date-fns-1.30.1.tgz
https://registry.yarnpkg.com/date-now/-/date-now-0.1.4.tgz
https://registry.yarnpkg.com/debug-log/-/debug-log-1.0.1.tgz
https://registry.yarnpkg.com/debug/-/debug-2.6.9.tgz
https://registry.yarnpkg.com/debug/-/debug-3.2.6.tgz
https://registry.yarnpkg.com/debug/-/debug-4.1.1.tgz
https://registry.yarnpkg.com/decamelize/-/decamelize-1.2.0.tgz
https://registry.yarnpkg.com/decode-uri-component/-/decode-uri-component-0.2.0.tgz
https://registry.yarnpkg.com/dedent/-/dedent-0.7.0.tgz
https://registry.yarnpkg.com/deep-eql/-/deep-eql-3.0.1.tgz
https://registry.yarnpkg.com/deep-extend/-/deep-extend-0.6.0.tgz
https://registry.yarnpkg.com/deep-is/-/deep-is-0.1.3.tgz
https://registry.yarnpkg.com/deepmerge/-/deepmerge-4.0.0.tgz
https://registry.yarnpkg.com/defaults/-/defaults-1.0.3.tgz
https://registry.yarnpkg.com/define-properties/-/define-properties-1.1.3.tgz
https://registry.yarnpkg.com/define-property/-/define-property-0.2.5.tgz
https://registry.yarnpkg.com/define-property/-/define-property-1.0.0.tgz
https://registry.yarnpkg.com/define-property/-/define-property-2.0.2.tgz
https://registry.yarnpkg.com/deglob/-/deglob-2.1.1.tgz
https://registry.yarnpkg.com/del/-/del-3.0.0.tgz
https://registry.yarnpkg.com/delayed-stream/-/delayed-stream-1.0.0.tgz
https://registry.yarnpkg.com/delegates/-/delegates-1.0.0.tgz
https://registry.yarnpkg.com/depd/-/depd-1.1.2.tgz
https://registry.yarnpkg.com/deprecation/-/deprecation-2.3.1.tgz
https://registry.yarnpkg.com/des.js/-/des.js-1.0.0.tgz
https://registry.yarnpkg.com/destroy/-/destroy-1.0.4.tgz
https://registry.yarnpkg.com/detect-file/-/detect-file-1.0.0.tgz
https://registry.yarnpkg.com/detect-libc/-/detect-libc-1.0.3.tgz
https://registry.yarnpkg.com/diff/-/diff-3.5.0.tgz
https://registry.yarnpkg.com/diffie-hellman/-/diffie-hellman-5.0.3.tgz
https://registry.yarnpkg.com/dir-glob/-/dir-glob-2.0.0.tgz
https://registry.yarnpkg.com/doctrine/-/doctrine-1.5.0.tgz
https://registry.yarnpkg.com/doctrine/-/doctrine-2.1.0.tgz
https://registry.yarnpkg.com/doctrine/-/doctrine-3.0.0.tgz
https://registry.yarnpkg.com/domain-browser/-/domain-browser-1.2.0.tgz
https://registry.yarnpkg.com/dotenv-safe/-/dotenv-safe-4.0.4.tgz
https://registry.yarnpkg.com/dotenv/-/dotenv-4.0.0.tgz
https://registry.yarnpkg.com/dugite/-/dugite-1.87.0.tgz
https://registry.yarnpkg.com/duplexer/-/duplexer-0.1.1.tgz
https://registry.yarnpkg.com/duplexer3/-/duplexer3-0.1.4.tgz
https://registry.yarnpkg.com/duplexify/-/duplexify-3.7.1.tgz
https://registry.yarnpkg.com/ecc-jsbn/-/ecc-jsbn-0.1.2.tgz
https://registry.yarnpkg.com/ecdsa-sig-formatter/-/ecdsa-sig-formatter-1.0.11.tgz
https://registry.yarnpkg.com/ee-first/-/ee-first-1.1.1.tgz
https://registry.yarnpkg.com/electron-docs/-/electron-docs-3.0.2.tgz
https://registry.yarnpkg.com/elegant-spinner/-/elegant-spinner-1.0.1.tgz
https://registry.yarnpkg.com/elliptic/-/elliptic-6.5.0.tgz
https://registry.yarnpkg.com/emoji-regex/-/emoji-regex-7.0.3.tgz
https://registry.yarnpkg.com/emojis-list/-/emojis-list-2.1.0.tgz
https://registry.yarnpkg.com/emojis-list/-/emojis-list-3.0.0.tgz
https://registry.yarnpkg.com/encodeurl/-/encodeurl-1.0.2.tgz
https://registry.yarnpkg.com/end-of-stream/-/end-of-stream-1.4.4.tgz
https://registry.yarnpkg.com/enhanced-resolve/-/enhanced-resolve-4.1.0.tgz
https://registry.yarnpkg.com/enhanced-resolve/-/enhanced-resolve-4.2.0.tgz
https://registry.yarnpkg.com/ensure-posix-path/-/ensure-posix-path-1.1.1.tgz
https://registry.yarnpkg.com/entities/-/entities-1.1.2.tgz
https://registry.yarnpkg.com/errno/-/errno-0.1.7.tgz
https://registry.yarnpkg.com/error-ex/-/error-ex-1.3.2.tgz
https://registry.yarnpkg.com/es-abstract/-/es-abstract-1.13.0.tgz
https://registry.yarnpkg.com/es-to-primitive/-/es-to-primitive-1.2.0.tgz
https://registry.yarnpkg.com/es6-object-assign/-/es6-object-assign-1.1.0.tgz
https://registry.yarnpkg.com/escape-html/-/escape-html-1.0.3.tgz
https://registry.yarnpkg.com/escape-string-regexp/-/escape-string-regexp-1.0.5.tgz
https://registry.yarnpkg.com/eslint-config-standard-jsx/-/eslint-config-standard-jsx-6.0.2.tgz
https://registry.yarnpkg.com/eslint-config-standard/-/eslint-config-standard-12.0.0.tgz
https://registry.yarnpkg.com/eslint-import-resolver-node/-/eslint-import-resolver-node-0.3.2.tgz
https://registry.yarnpkg.com/eslint-module-utils/-/eslint-module-utils-2.4.0.tgz
https://registry.yarnpkg.com/eslint-plugin-es/-/eslint-plugin-es-1.4.0.tgz
https://registry.yarnpkg.com/eslint-plugin-import/-/eslint-plugin-import-2.14.0.tgz
https://registry.yarnpkg.com/eslint-plugin-import/-/eslint-plugin-import-2.18.0.tgz
https://registry.yarnpkg.com/eslint-plugin-mocha/-/eslint-plugin-mocha-5.3.0.tgz
https://registry.yarnpkg.com/eslint-plugin-node/-/eslint-plugin-node-7.0.1.tgz
https://registry.yarnpkg.com/eslint-plugin-node/-/eslint-plugin-node-8.0.1.tgz
https://registry.yarnpkg.com/eslint-plugin-promise/-/eslint-plugin-promise-4.0.1.tgz
https://registry.yarnpkg.com/eslint-plugin-react/-/eslint-plugin-react-7.11.1.tgz
https://registry.yarnpkg.com/eslint-plugin-standard/-/eslint-plugin-standard-4.0.0.tgz
https://registry.yarnpkg.com/eslint-plugin-typescript/-/eslint-plugin-typescript-0.14.0.tgz
https://registry.yarnpkg.com/eslint-scope/-/eslint-scope-4.0.3.tgz
https://registry.yarnpkg.com/eslint-scope/-/eslint-scope-5.0.0.tgz
https://registry.yarnpkg.com/eslint-utils/-/eslint-utils-1.4.2.tgz
https://registry.yarnpkg.com/eslint-utils/-/eslint-utils-1.4.3.tgz
https://registry.yarnpkg.com/eslint-visitor-keys/-/eslint-visitor-keys-1.1.0.tgz
https://registry.yarnpkg.com/eslint/-/eslint-5.16.0.tgz
https://registry.yarnpkg.com/eslint/-/eslint-5.4.0.tgz
https://registry.yarnpkg.com/espree/-/espree-4.1.0.tgz
https://registry.yarnpkg.com/espree/-/espree-5.0.1.tgz
https://registry.yarnpkg.com/esprima/-/esprima-4.0.1.tgz
https://registry.yarnpkg.com/esquery/-/esquery-1.0.1.tgz
https://registry.yarnpkg.com/esrecurse/-/esrecurse-4.2.1.tgz
https://registry.yarnpkg.com/estraverse/-/estraverse-4.3.0.tgz
https://registry.yarnpkg.com/esutils/-/esutils-2.0.3.tgz
https://registry.yarnpkg.com/etag/-/etag-1.8.1.tgz
https://registry.yarnpkg.com/events-to-array/-/events-to-array-1.1.2.tgz
https://registry.yarnpkg.com/events/-/events-3.0.0.tgz
https://registry.yarnpkg.com/evp_bytestokey/-/evp_bytestokey-1.0.3.tgz
https://registry.yarnpkg.com/execa/-/execa-1.0.0.tgz
https://registry.yarnpkg.com/exit-hook/-/exit-hook-1.1.1.tgz
https://registry.yarnpkg.com/expand-brackets/-/expand-brackets-0.1.5.tgz
https://registry.yarnpkg.com/expand-brackets/-/expand-brackets-2.1.4.tgz
https://registry.yarnpkg.com/expand-range/-/expand-range-1.8.2.tgz
https://registry.yarnpkg.com/expand-tilde/-/expand-tilde-2.0.2.tgz
https://registry.yarnpkg.com/express/-/express-4.17.1.tgz
https://registry.yarnpkg.com/extend-shallow/-/extend-shallow-2.0.1.tgz
https://registry.yarnpkg.com/extend-shallow/-/extend-shallow-3.0.2.tgz
https://registry.yarnpkg.com/extend/-/extend-3.0.2.tgz
https://registry.yarnpkg.com/external-editor/-/external-editor-2.2.0.tgz
https://registry.yarnpkg.com/external-editor/-/external-editor-3.1.0.tgz
https://registry.yarnpkg.com/extglob/-/extglob-0.3.2.tgz
https://registry.yarnpkg.com/extglob/-/extglob-2.0.4.tgz
https://registry.yarnpkg.com/extsprintf/-/extsprintf-1.3.0.tgz
https://registry.yarnpkg.com/extsprintf/-/extsprintf-1.4.0.tgz
https://registry.yarnpkg.com/fast-deep-equal/-/fast-deep-equal-2.0.1.tgz
https://registry.yarnpkg.com/fast-deep-equal/-/fast-deep-equal-3.1.1.tgz
https://registry.yarnpkg.com/fast-glob/-/fast-glob-2.2.7.tgz
https://registry.yarnpkg.com/fast-json-stable-stringify/-/fast-json-stable-stringify-2.0.0.tgz
https://registry.yarnpkg.com/fast-levenshtein/-/fast-levenshtein-2.0.6.tgz
https://registry.yarnpkg.com/fault/-/fault-1.0.3.tgz
https://registry.yarnpkg.com/figgy-pudding/-/figgy-pudding-3.5.1.tgz
https://registry.yarnpkg.com/figures/-/figures-1.7.0.tgz
https://registry.yarnpkg.com/figures/-/figures-2.0.0.tgz
https://registry.yarnpkg.com/file-entry-cache/-/file-entry-cache-2.0.0.tgz
https://registry.yarnpkg.com/file-entry-cache/-/file-entry-cache-5.0.1.tgz
https://registry.yarnpkg.com/filename-regex/-/filename-regex-2.0.1.tgz
https://registry.yarnpkg.com/fill-range/-/fill-range-2.2.4.tgz
https://registry.yarnpkg.com/fill-range/-/fill-range-4.0.0.tgz
https://registry.yarnpkg.com/fill-range/-/fill-range-7.0.1.tgz
https://registry.yarnpkg.com/finalhandler/-/finalhandler-1.1.2.tgz
https://registry.yarnpkg.com/find-cache-dir/-/find-cache-dir-2.1.0.tgz
https://registry.yarnpkg.com/find-root/-/find-root-1.1.0.tgz
https://registry.yarnpkg.com/find-up/-/find-up-1.1.2.tgz
https://registry.yarnpkg.com/find-up/-/find-up-2.1.0.tgz
https://registry.yarnpkg.com/find-up/-/find-up-3.0.0.tgz
https://registry.yarnpkg.com/find-up/-/find-up-4.1.0.tgz
https://registry.yarnpkg.com/findup-sync/-/findup-sync-3.0.0.tgz
https://registry.yarnpkg.com/flat-cache/-/flat-cache-1.3.4.tgz
https://registry.yarnpkg.com/flat-cache/-/flat-cache-2.0.1.tgz
https://registry.yarnpkg.com/flatted/-/flatted-2.0.1.tgz
https://registry.yarnpkg.com/flush-write-stream/-/flush-write-stream-1.1.1.tgz
https://registry.yarnpkg.com/fn-name/-/fn-name-2.0.1.tgz
https://registry.yarnpkg.com/folder-hash/-/folder-hash-2.1.2.tgz
https://registry.yarnpkg.com/for-in/-/for-in-1.0.2.tgz
https://registry.yarnpkg.com/for-own/-/for-own-0.1.5.tgz
https://registry.yarnpkg.com/forever-agent/-/forever-agent-0.6.1.tgz
https://registry.yarnpkg.com/form-data/-/form-data-2.3.3.tgz
https://registry.yarnpkg.com/format/-/format-0.2.2.tgz
https://registry.yarnpkg.com/forwarded/-/forwarded-0.1.2.tgz
https://registry.yarnpkg.com/fragment-cache/-/fragment-cache-0.2.1.tgz
https://registry.yarnpkg.com/fresh/-/fresh-0.5.2.tgz
https://registry.yarnpkg.com/from2/-/from2-2.3.0.tgz
https://registry.yarnpkg.com/fs-constants/-/fs-constants-1.0.0.tgz
https://registry.yarnpkg.com/fs-extra/-/fs-extra-7.0.1.tgz
https://registry.yarnpkg.com/fs-minipass/-/fs-minipass-1.2.6.tgz
https://registry.yarnpkg.com/fs-write-stream-atomic/-/fs-write-stream-atomic-1.0.10.tgz
https://registry.yarnpkg.com/fs.realpath/-/fs.realpath-1.0.0.tgz
https://registry.yarnpkg.com/fsevents/-/fsevents-1.2.9.tgz
https://registry.yarnpkg.com/fsevents/-/fsevents-2.1.3.tgz
https://registry.yarnpkg.com/function-bind/-/function-bind-1.1.1.tgz
https://registry.yarnpkg.com/functional-red-black-tree/-/functional-red-black-tree-1.0.1.tgz
https://registry.yarnpkg.com/g-status/-/g-status-2.0.2.tgz
https://registry.yarnpkg.com/gauge/-/gauge-2.7.4.tgz
https://registry.yarnpkg.com/get-caller-file/-/get-caller-file-2.0.5.tgz
https://registry.yarnpkg.com/get-func-name/-/get-func-name-2.0.0.tgz
https://registry.yarnpkg.com/get-own-enumerable-property-symbols/-/get-own-enumerable-property-symbols-3.0.0.tgz
https://registry.yarnpkg.com/get-stdin/-/get-stdin-4.0.1.tgz
https://registry.yarnpkg.com/get-stdin/-/get-stdin-6.0.0.tgz
https://registry.yarnpkg.com/get-stdin/-/get-stdin-7.0.0.tgz
https://registry.yarnpkg.com/get-stream/-/get-stream-3.0.0.tgz
https://registry.yarnpkg.com/get-stream/-/get-stream-4.1.0.tgz
https://registry.yarnpkg.com/get-value/-/get-value-2.0.6.tgz
https://registry.yarnpkg.com/getpass/-/getpass-0.1.7.tgz
https://registry.yarnpkg.com/glob-base/-/glob-base-0.3.0.tgz
https://registry.yarnpkg.com/glob-parent/-/glob-parent-2.0.0.tgz
https://registry.yarnpkg.com/glob-parent/-/glob-parent-3.1.0.tgz
https://registry.yarnpkg.com/glob-parent/-/glob-parent-5.1.1.tgz
https://registry.yarnpkg.com/glob-to-regexp/-/glob-to-regexp-0.3.0.tgz
https://registry.yarnpkg.com/glob/-/glob-7.1.4.tgz
https://registry.yarnpkg.com/glob/-/glob-7.1.5.tgz
https://registry.yarnpkg.com/global-modules/-/global-modules-1.0.0.tgz
https://registry.yarnpkg.com/global-modules/-/global-modules-2.0.0.tgz
https://registry.yarnpkg.com/global-prefix/-/global-prefix-1.0.2.tgz
https://registry.yarnpkg.com/global-prefix/-/global-prefix-3.0.0.tgz
https://registry.yarnpkg.com/globals/-/globals-11.12.0.tgz
https://registry.yarnpkg.com/globby/-/globby-6.1.0.tgz
https://registry.yarnpkg.com/globby/-/globby-8.0.2.tgz
https://registry.yarnpkg.com/got/-/got-6.7.1.tgz
https://registry.yarnpkg.com/graceful-fs/-/graceful-fs-4.1.15.tgz
https://registry.yarnpkg.com/graceful-fs/-/graceful-fs-4.2.0.tgz
https://registry.yarnpkg.com/gunzip-maybe/-/gunzip-maybe-1.4.1.tgz
https://registry.yarnpkg.com/har-schema/-/har-schema-2.0.0.tgz
https://registry.yarnpkg.com/har-validator/-/har-validator-5.1.3.tgz
https://registry.yarnpkg.com/has-ansi/-/has-ansi-2.0.0.tgz
https://registry.yarnpkg.com/has-flag/-/has-flag-2.0.0.tgz
https://registry.yarnpkg.com/has-flag/-/has-flag-3.0.0.tgz
https://registry.yarnpkg.com/has-symbols/-/has-symbols-1.0.0.tgz
https://registry.yarnpkg.com/has-unicode/-/has-unicode-2.0.1.tgz
https://registry.yarnpkg.com/has-value/-/has-value-0.3.1.tgz
https://registry.yarnpkg.com/has-value/-/has-value-1.0.0.tgz
https://registry.yarnpkg.com/has-values/-/has-values-0.1.4.tgz
https://registry.yarnpkg.com/has-values/-/has-values-1.0.0.tgz
https://registry.yarnpkg.com/has/-/has-1.0.3.tgz
https://registry.yarnpkg.com/hash-base/-/hash-base-3.0.4.tgz
https://registry.yarnpkg.com/hash.js/-/hash.js-1.1.7.tgz
https://registry.yarnpkg.com/hmac-drbg/-/hmac-drbg-1.0.1.tgz
https://registry.yarnpkg.com/homedir-polyfill/-/homedir-polyfill-1.0.3.tgz
https://registry.yarnpkg.com/hosted-git-info/-/hosted-git-info-2.7.1.tgz
https://registry.yarnpkg.com/http-errors/-/http-errors-1.7.2.tgz
https://registry.yarnpkg.com/http-errors/-/http-errors-1.7.3.tgz
https://registry.yarnpkg.com/http-signature/-/http-signature-1.2.0.tgz
https://registry.yarnpkg.com/https-browserify/-/https-browserify-1.0.0.tgz
https://registry.yarnpkg.com/husky/-/husky-2.7.0.tgz
https://registry.yarnpkg.com/iconv-lite/-/iconv-lite-0.4.24.tgz
https://registry.yarnpkg.com/ieee754/-/ieee754-1.1.13.tgz
https://registry.yarnpkg.com/iferr/-/iferr-0.1.5.tgz
https://registry.yarnpkg.com/ignore-walk/-/ignore-walk-3.0.1.tgz
https://registry.yarnpkg.com/ignore/-/ignore-3.3.10.tgz
https://registry.yarnpkg.com/ignore/-/ignore-4.0.6.tgz
https://registry.yarnpkg.com/ignore/-/ignore-5.1.2.tgz
https://registry.yarnpkg.com/import-fresh/-/import-fresh-2.0.0.tgz
https://registry.yarnpkg.com/import-fresh/-/import-fresh-3.1.0.tgz
https://registry.yarnpkg.com/import-local/-/import-local-2.0.0.tgz
https://registry.yarnpkg.com/imurmurhash/-/imurmurhash-0.1.4.tgz
https://registry.yarnpkg.com/indent-string/-/indent-string-2.1.0.tgz
https://registry.yarnpkg.com/indent-string/-/indent-string-3.2.0.tgz
https://registry.yarnpkg.com/infer-owner/-/infer-owner-1.0.4.tgz
https://registry.yarnpkg.com/inflight/-/inflight-1.0.6.tgz
https://registry.yarnpkg.com/inherits/-/inherits-2.0.1.tgz
https://registry.yarnpkg.com/inherits/-/inherits-2.0.3.tgz
https://registry.yarnpkg.com/inherits/-/inherits-2.0.4.tgz
https://registry.yarnpkg.com/ini/-/ini-1.3.5.tgz
https://registry.yarnpkg.com/inquirer/-/inquirer-5.2.0.tgz
https://registry.yarnpkg.com/inquirer/-/inquirer-6.5.2.tgz
https://registry.yarnpkg.com/interpret/-/interpret-1.2.0.tgz
https://registry.yarnpkg.com/interpret/-/interpret-1.4.0.tgz
https://registry.yarnpkg.com/ipaddr.js/-/ipaddr.js-1.9.0.tgz
https://registry.yarnpkg.com/irregular-plurals/-/irregular-plurals-2.0.0.tgz
https://registry.yarnpkg.com/is-accessor-descriptor/-/is-accessor-descriptor-0.1.6.tgz
https://registry.yarnpkg.com/is-accessor-descriptor/-/is-accessor-descriptor-1.0.0.tgz
https://registry.yarnpkg.com/is-alphabetical/-/is-alphabetical-1.0.3.tgz
https://registry.yarnpkg.com/is-alphanumeric/-/is-alphanumeric-1.0.0.tgz
https://registry.yarnpkg.com/is-alphanumerical/-/is-alphanumerical-1.0.3.tgz
https://registry.yarnpkg.com/is-arrayish/-/is-arrayish-0.2.1.tgz
https://registry.yarnpkg.com/is-binary-path/-/is-binary-path-1.0.1.tgz
https://registry.yarnpkg.com/is-binary-path/-/is-binary-path-2.1.0.tgz
https://registry.yarnpkg.com/is-buffer/-/is-buffer-1.1.6.tgz
https://registry.yarnpkg.com/is-callable/-/is-callable-1.1.4.tgz
https://registry.yarnpkg.com/is-ci/-/is-ci-2.0.0.tgz
https://registry.yarnpkg.com/is-data-descriptor/-/is-data-descriptor-0.1.4.tgz
https://registry.yarnpkg.com/is-data-descriptor/-/is-data-descriptor-1.0.0.tgz
https://registry.yarnpkg.com/is-date-object/-/is-date-object-1.0.1.tgz
https://registry.yarnpkg.com/is-decimal/-/is-decimal-1.0.3.tgz
https://registry.yarnpkg.com/is-deflate/-/is-deflate-1.0.0.tgz
https://registry.yarnpkg.com/is-descriptor/-/is-descriptor-0.1.6.tgz
https://registry.yarnpkg.com/is-descriptor/-/is-descriptor-1.0.2.tgz
https://registry.yarnpkg.com/is-directory/-/is-directory-0.3.1.tgz
https://registry.yarnpkg.com/is-dotfile/-/is-dotfile-1.0.3.tgz
https://registry.yarnpkg.com/is-empty/-/is-empty-1.2.0.tgz
https://registry.yarnpkg.com/is-equal-shallow/-/is-equal-shallow-0.1.3.tgz
https://registry.yarnpkg.com/is-extendable/-/is-extendable-0.1.1.tgz
https://registry.yarnpkg.com/is-extendable/-/is-extendable-1.0.1.tgz
https://registry.yarnpkg.com/is-extglob/-/is-extglob-1.0.0.tgz
https://registry.yarnpkg.com/is-extglob/-/is-extglob-2.1.1.tgz
https://registry.yarnpkg.com/is-finite/-/is-finite-1.0.2.tgz
https://registry.yarnpkg.com/is-fullwidth-code-point/-/is-fullwidth-code-point-1.0.0.tgz
https://registry.yarnpkg.com/is-fullwidth-code-point/-/is-fullwidth-code-point-2.0.0.tgz
https://registry.yarnpkg.com/is-glob/-/is-glob-2.0.1.tgz
https://registry.yarnpkg.com/is-glob/-/is-glob-3.1.0.tgz
https://registry.yarnpkg.com/is-glob/-/is-glob-4.0.1.tgz
https://registry.yarnpkg.com/is-gzip/-/is-gzip-1.0.0.tgz
https://registry.yarnpkg.com/is-hexadecimal/-/is-hexadecimal-1.0.3.tgz
https://registry.yarnpkg.com/is-hidden/-/is-hidden-1.1.2.tgz
https://registry.yarnpkg.com/is-number/-/is-number-2.1.0.tgz
https://registry.yarnpkg.com/is-number/-/is-number-3.0.0.tgz
https://registry.yarnpkg.com/is-number/-/is-number-4.0.0.tgz
https://registry.yarnpkg.com/is-number/-/is-number-7.0.0.tgz
https://registry.yarnpkg.com/is-obj/-/is-obj-1.0.1.tgz
https://registry.yarnpkg.com/is-object/-/is-object-1.0.1.tgz
https://registry.yarnpkg.com/is-observable/-/is-observable-1.1.0.tgz
https://registry.yarnpkg.com/is-path-cwd/-/is-path-cwd-1.0.0.tgz
https://registry.yarnpkg.com/is-path-in-cwd/-/is-path-in-cwd-1.0.1.tgz
https://registry.yarnpkg.com/is-path-inside/-/is-path-inside-1.0.1.tgz
https://registry.yarnpkg.com/is-plain-obj/-/is-plain-obj-1.1.0.tgz
https://registry.yarnpkg.com/is-plain-object/-/is-plain-object-2.0.4.tgz
https://registry.yarnpkg.com/is-plain-object/-/is-plain-object-3.0.0.tgz
https://registry.yarnpkg.com/is-plain-object/-/is-plain-object-4.1.1.tgz
https://registry.yarnpkg.com/is-plain-object/-/is-plain-object-5.0.0.tgz
https://registry.yarnpkg.com/is-posix-bracket/-/is-posix-bracket-0.1.1.tgz
https://registry.yarnpkg.com/is-primitive/-/is-primitive-2.0.0.tgz
https://registry.yarnpkg.com/is-promise/-/is-promise-2.1.0.tgz
https://registry.yarnpkg.com/is-redirect/-/is-redirect-1.0.0.tgz
https://registry.yarnpkg.com/is-regex/-/is-regex-1.0.4.tgz
https://registry.yarnpkg.com/is-regexp/-/is-regexp-1.0.0.tgz
https://registry.yarnpkg.com/is-resolvable/-/is-resolvable-1.1.0.tgz
https://registry.yarnpkg.com/is-retry-allowed/-/is-retry-allowed-1.2.0.tgz
https://registry.yarnpkg.com/is-stream/-/is-stream-1.1.0.tgz
https://registry.yarnpkg.com/is-symbol/-/is-symbol-1.0.2.tgz
https://registry.yarnpkg.com/is-typedarray/-/is-typedarray-1.0.0.tgz
https://registry.yarnpkg.com/is-utf8/-/is-utf8-0.2.1.tgz
https://registry.yarnpkg.com/is-whitespace-character/-/is-whitespace-character-1.0.3.tgz
https://registry.yarnpkg.com/is-windows/-/is-windows-1.0.2.tgz
https://registry.yarnpkg.com/is-word-character/-/is-word-character-1.0.3.tgz
https://registry.yarnpkg.com/is-wsl/-/is-wsl-1.1.0.tgz
https://registry.yarnpkg.com/isarray/-/isarray-0.0.1.tgz
https://registry.yarnpkg.com/isarray/-/isarray-1.0.0.tgz
https://registry.yarnpkg.com/isexe/-/isexe-2.0.0.tgz
https://registry.yarnpkg.com/isobject/-/isobject-2.1.0.tgz
https://registry.yarnpkg.com/isobject/-/isobject-3.0.1.tgz
https://registry.yarnpkg.com/isobject/-/isobject-4.0.0.tgz
https://registry.yarnpkg.com/isstream/-/isstream-0.1.2.tgz
https://registry.yarnpkg.com/js-tokens/-/js-tokens-3.0.2.tgz
https://registry.yarnpkg.com/js-tokens/-/js-tokens-4.0.0.tgz
https://registry.yarnpkg.com/js-yaml/-/js-yaml-3.13.1.tgz
https://registry.yarnpkg.com/jsbn/-/jsbn-0.1.1.tgz
https://registry.yarnpkg.com/json-parse-better-errors/-/json-parse-better-errors-1.0.2.tgz
https://registry.yarnpkg.com/json-schema-traverse/-/json-schema-traverse-0.4.1.tgz
https://registry.yarnpkg.com/json-schema/-/json-schema-0.2.3.tgz
https://registry.yarnpkg.com/json-stable-stringify-without-jsonify/-/json-stable-stringify-without-jsonify-1.0.1.tgz
https://registry.yarnpkg.com/json-stringify-safe/-/json-stringify-safe-5.0.1.tgz
https://registry.yarnpkg.com/json5/-/json5-1.0.1.tgz
https://registry.yarnpkg.com/json5/-/json5-2.1.3.tgz
https://registry.yarnpkg.com/jsonfile/-/jsonfile-4.0.0.tgz
https://registry.yarnpkg.com/jsonwebtoken/-/jsonwebtoken-8.5.1.tgz
https://registry.yarnpkg.com/jsprim/-/jsprim-1.4.1.tgz
https://registry.yarnpkg.com/jsx-ast-utils/-/jsx-ast-utils-2.2.1.tgz
https://registry.yarnpkg.com/jwa/-/jwa-1.4.1.tgz
https://registry.yarnpkg.com/jws/-/jws-3.2.2.tgz
https://registry.yarnpkg.com/kind-of/-/kind-of-3.2.2.tgz
https://registry.yarnpkg.com/kind-of/-/kind-of-4.0.0.tgz
https://registry.yarnpkg.com/kind-of/-/kind-of-5.1.0.tgz
https://registry.yarnpkg.com/kind-of/-/kind-of-6.0.2.tgz
https://registry.yarnpkg.com/klaw/-/klaw-3.0.0.tgz
https://registry.yarnpkg.com/levn/-/levn-0.3.0.tgz
https://registry.yarnpkg.com/linkify-it/-/linkify-it-2.2.0.tgz
https://registry.yarnpkg.com/lint-staged/-/lint-staged-8.2.1.tgz
https://registry.yarnpkg.com/lint/-/lint-1.1.2.tgz
https://registry.yarnpkg.com/listr-silent-renderer/-/listr-silent-renderer-1.1.1.tgz
https://registry.yarnpkg.com/listr-update-renderer/-/listr-update-renderer-0.5.0.tgz
https://registry.yarnpkg.com/listr-verbose-renderer/-/listr-verbose-renderer-0.5.0.tgz
https://registry.yarnpkg.com/listr/-/listr-0.14.3.tgz
https://registry.yarnpkg.com/load-json-file/-/load-json-file-1.1.0.tgz
https://registry.yarnpkg.com/load-json-file/-/load-json-file-2.0.0.tgz
https://registry.yarnpkg.com/load-json-file/-/load-json-file-4.0.0.tgz
https://registry.yarnpkg.com/load-plugin/-/load-plugin-2.3.1.tgz
https://registry.yarnpkg.com/loader-runner/-/loader-runner-2.4.0.tgz
https://registry.yarnpkg.com/loader-utils/-/loader-utils-1.2.3.tgz
https://registry.yarnpkg.com/loader-utils/-/loader-utils-1.4.0.tgz
https://registry.yarnpkg.com/loader-utils/-/loader-utils-2.0.0.tgz
https://registry.yarnpkg.com/locate-path/-/locate-path-2.0.0.tgz
https://registry.yarnpkg.com/locate-path/-/locate-path-3.0.0.tgz
https://registry.yarnpkg.com/locate-path/-/locate-path-5.0.0.tgz
https://registry.yarnpkg.com/lodash.camelcase/-/lodash.camelcase-4.3.0.tgz
https://registry.yarnpkg.com/lodash.flatten/-/lodash.flatten-4.4.0.tgz
https://registry.yarnpkg.com/lodash.get/-/lodash.get-4.4.2.tgz
https://registry.yarnpkg.com/lodash.includes/-/lodash.includes-4.3.0.tgz
https://registry.yarnpkg.com/lodash.isboolean/-/lodash.isboolean-3.0.3.tgz
https://registry.yarnpkg.com/lodash.isinteger/-/lodash.isinteger-4.0.4.tgz
https://registry.yarnpkg.com/lodash.isnumber/-/lodash.isnumber-3.0.3.tgz
https://registry.yarnpkg.com/lodash.isplainobject/-/lodash.isplainobject-4.0.6.tgz
https://registry.yarnpkg.com/lodash.isstring/-/lodash.isstring-4.0.1.tgz
https://registry.yarnpkg.com/lodash.once/-/lodash.once-4.1.1.tgz
https://registry.yarnpkg.com/lodash.range/-/lodash.range-3.2.0.tgz
https://registry.yarnpkg.com/lodash.set/-/lodash.set-4.3.2.tgz
https://registry.yarnpkg.com/lodash.unescape/-/lodash.unescape-4.0.1.tgz
https://registry.yarnpkg.com/lodash.uniq/-/lodash.uniq-4.5.0.tgz
https://registry.yarnpkg.com/lodash/-/lodash-4.17.14.tgz
https://registry.yarnpkg.com/lodash/-/lodash-4.17.15.tgz
https://registry.yarnpkg.com/log-symbols/-/log-symbols-1.0.2.tgz
https://registry.yarnpkg.com/log-symbols/-/log-symbols-2.2.0.tgz
https://registry.yarnpkg.com/log-update/-/log-update-2.3.0.tgz
https://registry.yarnpkg.com/longest-streak/-/longest-streak-2.0.3.tgz
https://registry.yarnpkg.com/loose-envify/-/loose-envify-1.4.0.tgz
https://registry.yarnpkg.com/loud-rejection/-/loud-rejection-1.6.0.tgz
https://registry.yarnpkg.com/lowercase-keys/-/lowercase-keys-1.0.1.tgz
https://registry.yarnpkg.com/lru-cache/-/lru-cache-5.1.1.tgz
https://registry.yarnpkg.com/lru-cache/-/lru-cache-6.0.0.tgz
https://registry.yarnpkg.com/macos-release/-/macos-release-2.3.0.tgz
https://registry.yarnpkg.com/make-dir/-/make-dir-2.1.0.tgz
https://registry.yarnpkg.com/make-error/-/make-error-1.3.5.tgz
https://registry.yarnpkg.com/map-cache/-/map-cache-0.2.2.tgz
https://registry.yarnpkg.com/map-obj/-/map-obj-1.0.1.tgz
https://registry.yarnpkg.com/map-visit/-/map-visit-1.0.0.tgz
https://registry.yarnpkg.com/markdown-escapes/-/markdown-escapes-1.0.3.tgz
https://registry.yarnpkg.com/markdown-extensions/-/markdown-extensions-1.1.1.tgz
https://registry.yarnpkg.com/markdown-it/-/markdown-it-8.4.2.tgz
https://registry.yarnpkg.com/markdown-table/-/markdown-table-1.1.3.tgz
https://registry.yarnpkg.com/matcher-collection/-/matcher-collection-1.1.2.tgz
https://registry.yarnpkg.com/matcher/-/matcher-1.1.1.tgz
https://registry.yarnpkg.com/math-random/-/math-random-1.0.4.tgz
https://registry.yarnpkg.com/md5.js/-/md5.js-1.3.5.tgz
https://registry.yarnpkg.com/mdast-comment-marker/-/mdast-comment-marker-1.1.1.tgz
https://registry.yarnpkg.com/mdast-util-compact/-/mdast-util-compact-1.0.3.tgz
https://registry.yarnpkg.com/mdast-util-heading-style/-/mdast-util-heading-style-1.0.5.tgz
https://registry.yarnpkg.com/mdast-util-to-string/-/mdast-util-to-string-1.0.6.tgz
https://registry.yarnpkg.com/mdurl/-/mdurl-1.0.1.tgz
https://registry.yarnpkg.com/media-typer/-/media-typer-0.3.0.tgz
https://registry.yarnpkg.com/memory-fs/-/memory-fs-0.4.1.tgz
https://registry.yarnpkg.com/memory-fs/-/memory-fs-0.5.0.tgz
https://registry.yarnpkg.com/meow/-/meow-3.7.0.tgz
https://registry.yarnpkg.com/merge-descriptors/-/merge-descriptors-1.0.1.tgz
https://registry.yarnpkg.com/merge2/-/merge2-1.2.3.tgz
https://registry.yarnpkg.com/methods/-/methods-1.1.2.tgz
https://registry.yarnpkg.com/micromatch/-/micromatch-2.3.11.tgz
https://registry.yarnpkg.com/micromatch/-/micromatch-3.1.10.tgz
https://registry.yarnpkg.com/micromatch/-/micromatch-4.0.2.tgz
https://registry.yarnpkg.com/miller-rabin/-/miller-rabin-4.0.1.tgz
https://registry.yarnpkg.com/mime-db/-/mime-db-1.40.0.tgz
https://registry.yarnpkg.com/mime-types/-/mime-types-2.1.24.tgz
https://registry.yarnpkg.com/mime/-/mime-1.6.0.tgz
https://registry.yarnpkg.com/mimic-fn/-/mimic-fn-1.2.0.tgz
https://registry.yarnpkg.com/minimalistic-assert/-/minimalistic-assert-1.0.1.tgz
https://registry.yarnpkg.com/minimalistic-crypto-utils/-/minimalistic-crypto-utils-1.0.1.tgz
https://registry.yarnpkg.com/minimatch/-/minimatch-3.0.4.tgz
https://registry.yarnpkg.com/minimist/-/minimist-0.0.8.tgz
https://registry.yarnpkg.com/minimist/-/minimist-1.2.0.tgz
https://registry.yarnpkg.com/minimist/-/minimist-1.2.5.tgz
https://registry.yarnpkg.com/minipass/-/minipass-2.3.5.tgz
https://registry.yarnpkg.com/minizlib/-/minizlib-1.2.1.tgz
https://registry.yarnpkg.com/mississippi/-/mississippi-3.0.0.tgz
https://registry.yarnpkg.com/mixin-deep/-/mixin-deep-1.3.2.tgz
https://registry.yarnpkg.com/mkdirp/-/mkdirp-0.5.1.tgz
https://registry.yarnpkg.com/mkdirp/-/mkdirp-0.5.5.tgz
https://registry.yarnpkg.com/move-concurrently/-/move-concurrently-1.0.1.tgz
https://registry.yarnpkg.com/ms/-/ms-2.0.0.tgz
https://registry.yarnpkg.com/ms/-/ms-2.1.1.tgz
https://registry.yarnpkg.com/ms/-/ms-2.1.2.tgz
https://registry.yarnpkg.com/mute-stream/-/mute-stream-0.0.7.tgz
https://registry.yarnpkg.com/nan/-/nan-2.14.0.tgz
https://registry.yarnpkg.com/nanomatch/-/nanomatch-1.2.13.tgz
https://registry.yarnpkg.com/natural-compare/-/natural-compare-1.4.0.tgz
https://registry.yarnpkg.com/needle/-/needle-2.4.0.tgz
https://registry.yarnpkg.com/negotiator/-/negotiator-0.6.2.tgz
https://registry.yarnpkg.com/neo-async/-/neo-async-2.6.1.tgz
https://registry.yarnpkg.com/nice-try/-/nice-try-1.0.5.tgz
https://registry.yarnpkg.com/node-dir/-/node-dir-0.1.17.tgz
https://registry.yarnpkg.com/node-fetch/-/node-fetch-2.6.0.tgz
https://registry.yarnpkg.com/node-fetch/-/node-fetch-2.6.1.tgz
https://registry.yarnpkg.com/node-libs-browser/-/node-libs-browser-2.2.1.tgz
https://registry.yarnpkg.com/node-pre-gyp/-/node-pre-gyp-0.12.0.tgz
https://registry.yarnpkg.com/nopt/-/nopt-4.0.1.tgz
https://registry.yarnpkg.com/normalize-package-data/-/normalize-package-data-2.5.0.tgz
https://registry.yarnpkg.com/normalize-path/-/normalize-path-2.1.1.tgz
https://registry.yarnpkg.com/normalize-path/-/normalize-path-3.0.0.tgz
https://registry.yarnpkg.com/npm-bundled/-/npm-bundled-1.0.6.tgz
https://registry.yarnpkg.com/npm-packlist/-/npm-packlist-1.4.4.tgz
https://registry.yarnpkg.com/npm-path/-/npm-path-2.0.4.tgz
https://registry.yarnpkg.com/npm-prefix/-/npm-prefix-1.2.0.tgz
https://registry.yarnpkg.com/npm-run-path/-/npm-run-path-2.0.2.tgz
https://registry.yarnpkg.com/npm-which/-/npm-which-3.0.1.tgz
https://registry.yarnpkg.com/npmlog/-/npmlog-4.1.2.tgz
https://registry.yarnpkg.com/nugget/-/nugget-2.0.1.tgz
https://registry.yarnpkg.com/null-loader/-/null-loader-4.0.0.tgz
https://registry.yarnpkg.com/number-is-nan/-/number-is-nan-1.0.1.tgz
https://registry.yarnpkg.com/oauth-sign/-/oauth-sign-0.9.0.tgz
https://registry.yarnpkg.com/object-assign/-/object-assign-4.1.1.tgz
https://registry.yarnpkg.com/object-copy/-/object-copy-0.1.0.tgz
https://registry.yarnpkg.com/object-keys/-/object-keys-0.4.0.tgz
https://registry.yarnpkg.com/object-keys/-/object-keys-1.1.1.tgz
https://registry.yarnpkg.com/object-visit/-/object-visit-1.0.1.tgz
https://registry.yarnpkg.com/object.assign/-/object.assign-4.1.0.tgz
https://registry.yarnpkg.com/object.omit/-/object.omit-2.0.1.tgz
https://registry.yarnpkg.com/object.pick/-/object.pick-1.3.0.tgz
https://registry.yarnpkg.com/octokit-pagination-methods/-/octokit-pagination-methods-1.1.0.tgz
https://registry.yarnpkg.com/on-finished/-/on-finished-2.3.0.tgz
https://registry.yarnpkg.com/once/-/once-1.4.0.tgz
https://registry.yarnpkg.com/onetime/-/onetime-1.1.0.tgz
https://registry.yarnpkg.com/onetime/-/onetime-2.0.1.tgz
https://registry.yarnpkg.com/optimist/-/optimist-0.3.7.tgz
https://registry.yarnpkg.com/optionator/-/optionator-0.8.2.tgz
https://registry.yarnpkg.com/ora/-/ora-0.2.3.tgz
https://registry.yarnpkg.com/ora/-/ora-3.4.0.tgz
https://registry.yarnpkg.com/os-browserify/-/os-browserify-0.3.0.tgz
https://registry.yarnpkg.com/os-homedir/-/os-homedir-1.0.2.tgz
https://registry.yarnpkg.com/os-name/-/os-name-3.1.0.tgz
https://registry.yarnpkg.com/os-tmpdir/-/os-tmpdir-1.0.2.tgz
https://registry.yarnpkg.com/osenv/-/osenv-0.1.5.tgz
https://registry.yarnpkg.com/p-finally/-/p-finally-1.0.0.tgz
https://registry.yarnpkg.com/p-limit/-/p-limit-1.3.0.tgz
https://registry.yarnpkg.com/p-limit/-/p-limit-2.2.0.tgz
https://registry.yarnpkg.com/p-locate/-/p-locate-2.0.0.tgz
https://registry.yarnpkg.com/p-locate/-/p-locate-3.0.0.tgz
https://registry.yarnpkg.com/p-locate/-/p-locate-4.1.0.tgz
https://registry.yarnpkg.com/p-map/-/p-map-1.2.0.tgz
https://registry.yarnpkg.com/p-map/-/p-map-2.1.0.tgz
https://registry.yarnpkg.com/p-try/-/p-try-1.0.0.tgz
https://registry.yarnpkg.com/p-try/-/p-try-2.2.0.tgz
https://registry.yarnpkg.com/pako/-/pako-0.2.9.tgz
https://registry.yarnpkg.com/pako/-/pako-1.0.10.tgz
https://registry.yarnpkg.com/parallel-transform/-/parallel-transform-1.1.0.tgz
https://registry.yarnpkg.com/parent-module/-/parent-module-1.0.1.tgz
https://registry.yarnpkg.com/parse-asn1/-/parse-asn1-5.1.4.tgz
https://registry.yarnpkg.com/parse-entities/-/parse-entities-1.2.2.tgz
https://registry.yarnpkg.com/parse-gitignore/-/parse-gitignore-0.4.0.tgz
https://registry.yarnpkg.com/parse-glob/-/parse-glob-3.0.4.tgz
https://registry.yarnpkg.com/parse-json/-/parse-json-2.2.0.tgz
https://registry.yarnpkg.com/parse-json/-/parse-json-4.0.0.tgz
https://registry.yarnpkg.com/parse-ms/-/parse-ms-2.1.0.tgz
https://registry.yarnpkg.com/parse-passwd/-/parse-passwd-1.0.0.tgz
https://registry.yarnpkg.com/parseurl/-/parseurl-1.3.3.tgz
https://registry.yarnpkg.com/pascalcase/-/pascalcase-0.1.1.tgz
https://registry.yarnpkg.com/path-browserify/-/path-browserify-0.0.1.tgz
https://registry.yarnpkg.com/path-dirname/-/path-dirname-1.0.2.tgz
https://registry.yarnpkg.com/path-exists/-/path-exists-2.1.0.tgz
https://registry.yarnpkg.com/path-exists/-/path-exists-3.0.0.tgz
https://registry.yarnpkg.com/path-exists/-/path-exists-4.0.0.tgz
https://registry.yarnpkg.com/path-is-absolute/-/path-is-absolute-1.0.1.tgz
https://registry.yarnpkg.com/path-is-inside/-/path-is-inside-1.0.2.tgz
https://registry.yarnpkg.com/path-key/-/path-key-2.0.1.tgz
https://registry.yarnpkg.com/path-parse/-/path-parse-1.0.6.tgz
https://registry.yarnpkg.com/path-to-regexp/-/path-to-regexp-0.1.7.tgz
https://registry.yarnpkg.com/path-type/-/path-type-1.1.0.tgz
https://registry.yarnpkg.com/path-type/-/path-type-2.0.0.tgz
https://registry.yarnpkg.com/path-type/-/path-type-3.0.0.tgz
https://registry.yarnpkg.com/pathval/-/pathval-1.1.0.tgz
https://registry.yarnpkg.com/pbkdf2/-/pbkdf2-3.0.17.tgz
https://registry.yarnpkg.com/peek-stream/-/peek-stream-1.1.3.tgz
https://registry.yarnpkg.com/performance-now/-/performance-now-2.1.0.tgz
https://registry.yarnpkg.com/picomatch/-/picomatch-2.0.7.tgz
https://registry.yarnpkg.com/picomatch/-/picomatch-2.2.2.tgz
https://registry.yarnpkg.com/pify/-/pify-2.3.0.tgz
https://registry.yarnpkg.com/pify/-/pify-3.0.0.tgz
https://registry.yarnpkg.com/pify/-/pify-4.0.1.tgz
https://registry.yarnpkg.com/pinkie-promise/-/pinkie-promise-2.0.1.tgz
https://registry.yarnpkg.com/pinkie/-/pinkie-2.0.4.tgz
https://registry.yarnpkg.com/pkg-conf/-/pkg-conf-2.1.0.tgz
https://registry.yarnpkg.com/pkg-config/-/pkg-config-1.1.1.tgz
https://registry.yarnpkg.com/pkg-dir/-/pkg-dir-2.0.0.tgz
https://registry.yarnpkg.com/pkg-dir/-/pkg-dir-3.0.0.tgz
https://registry.yarnpkg.com/pkg-dir/-/pkg-dir-4.2.0.tgz
https://registry.yarnpkg.com/please-upgrade-node/-/please-upgrade-node-3.1.1.tgz
https://registry.yarnpkg.com/plur/-/plur-3.1.1.tgz
https://registry.yarnpkg.com/pluralize/-/pluralize-7.0.0.tgz
https://registry.yarnpkg.com/posix-character-classes/-/posix-character-classes-0.1.1.tgz
https://registry.yarnpkg.com/pre-flight/-/pre-flight-1.1.1.tgz
https://registry.yarnpkg.com/prelude-ls/-/prelude-ls-1.1.2.tgz
https://registry.yarnpkg.com/prepend-http/-/prepend-http-1.0.4.tgz
https://registry.yarnpkg.com/preserve/-/preserve-0.2.0.tgz
https://registry.yarnpkg.com/pretty-bytes/-/pretty-bytes-1.0.4.tgz
https://registry.yarnpkg.com/pretty-ms/-/pretty-ms-5.0.0.tgz
https://registry.yarnpkg.com/process-nextick-args/-/process-nextick-args-2.0.1.tgz
https://registry.yarnpkg.com/process/-/process-0.11.10.tgz
https://registry.yarnpkg.com/progress-stream/-/progress-stream-1.2.0.tgz
https://registry.yarnpkg.com/progress/-/progress-2.0.3.tgz
https://registry.yarnpkg.com/promise-inflight/-/promise-inflight-1.0.1.tgz
https://registry.yarnpkg.com/prop-types/-/prop-types-15.7.2.tgz
https://registry.yarnpkg.com/property-expr/-/property-expr-1.5.1.tgz
https://registry.yarnpkg.com/proxy-addr/-/proxy-addr-2.0.5.tgz
https://registry.yarnpkg.com/prr/-/prr-1.0.1.tgz
https://registry.yarnpkg.com/psl/-/psl-1.2.0.tgz
https://registry.yarnpkg.com/public-encrypt/-/public-encrypt-4.0.3.tgz
https://registry.yarnpkg.com/pump/-/pump-1.0.3.tgz
https://registry.yarnpkg.com/pump/-/pump-2.0.1.tgz
https://registry.yarnpkg.com/pump/-/pump-3.0.0.tgz
https://registry.yarnpkg.com/pumpify/-/pumpify-1.5.1.tgz
https://registry.yarnpkg.com/punycode/-/punycode-1.3.2.tgz
https://registry.yarnpkg.com/punycode/-/punycode-1.4.1.tgz
https://registry.yarnpkg.com/punycode/-/punycode-2.1.1.tgz
https://registry.yarnpkg.com/qs/-/qs-6.5.2.tgz
https://registry.yarnpkg.com/qs/-/qs-6.7.0.tgz
https://registry.yarnpkg.com/querystring-es3/-/querystring-es3-0.2.1.tgz
https://registry.yarnpkg.com/querystring/-/querystring-0.2.0.tgz
https://registry.yarnpkg.com/ramda/-/ramda-0.26.1.tgz
https://registry.yarnpkg.com/randomatic/-/randomatic-3.1.1.tgz
https://registry.yarnpkg.com/randombytes/-/randombytes-2.1.0.tgz
https://registry.yarnpkg.com/randomfill/-/randomfill-1.0.4.tgz
https://registry.yarnpkg.com/range-parser/-/range-parser-1.2.1.tgz
https://registry.yarnpkg.com/raw-body/-/raw-body-2.4.0.tgz
https://registry.yarnpkg.com/rc/-/rc-1.2.8.tgz
https://registry.yarnpkg.com/react-is/-/react-is-16.8.6.tgz
https://registry.yarnpkg.com/read-pkg-up/-/read-pkg-up-1.0.1.tgz
https://registry.yarnpkg.com/read-pkg-up/-/read-pkg-up-2.0.0.tgz
https://registry.yarnpkg.com/read-pkg/-/read-pkg-1.1.0.tgz
https://registry.yarnpkg.com/read-pkg/-/read-pkg-2.0.0.tgz
https://registry.yarnpkg.com/read-pkg/-/read-pkg-5.1.1.tgz
https://registry.yarnpkg.com/readable-stream/-/readable-stream-1.1.14.tgz
https://registry.yarnpkg.com/readable-stream/-/readable-stream-2.3.6.tgz
https://registry.yarnpkg.com/readdirp/-/readdirp-2.2.1.tgz
https://registry.yarnpkg.com/readdirp/-/readdirp-3.4.0.tgz
https://registry.yarnpkg.com/rechoir/-/rechoir-0.6.2.tgz
https://registry.yarnpkg.com/redent/-/redent-1.0.0.tgz
https://registry.yarnpkg.com/regenerator-runtime/-/regenerator-runtime-0.13.2.tgz
https://registry.yarnpkg.com/regex-cache/-/regex-cache-0.4.4.tgz
https://registry.yarnpkg.com/regex-not/-/regex-not-1.0.2.tgz
https://registry.yarnpkg.com/regexpp/-/regexpp-2.0.1.tgz
https://registry.yarnpkg.com/remark-cli/-/remark-cli-4.0.0.tgz
https://registry.yarnpkg.com/remark-lint-blockquote-indentation/-/remark-lint-blockquote-indentation-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-code-block-style/-/remark-lint-code-block-style-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-definition-case/-/remark-lint-definition-case-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-definition-spacing/-/remark-lint-definition-spacing-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-emphasis-marker/-/remark-lint-emphasis-marker-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-fenced-code-flag/-/remark-lint-fenced-code-flag-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-fenced-code-marker/-/remark-lint-fenced-code-marker-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-file-extension/-/remark-lint-file-extension-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-final-definition/-/remark-lint-final-definition-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-hard-break-spaces/-/remark-lint-hard-break-spaces-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-heading-increment/-/remark-lint-heading-increment-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-heading-style/-/remark-lint-heading-style-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-link-title-style/-/remark-lint-link-title-style-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-list-item-content-indent/-/remark-lint-list-item-content-indent-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-list-item-indent/-/remark-lint-list-item-indent-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-list-item-spacing/-/remark-lint-list-item-spacing-1.1.3.tgz
https://registry.yarnpkg.com/remark-lint-maximum-heading-length/-/remark-lint-maximum-heading-length-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-maximum-line-length/-/remark-lint-maximum-line-length-1.2.1.tgz
https://registry.yarnpkg.com/remark-lint-no-auto-link-without-protocol/-/remark-lint-no-auto-link-without-protocol-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-blockquote-without-marker/-/remark-lint-no-blockquote-without-marker-2.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-consecutive-blank-lines/-/remark-lint-no-consecutive-blank-lines-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-duplicate-headings/-/remark-lint-no-duplicate-headings-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-no-emphasis-as-heading/-/remark-lint-no-emphasis-as-heading-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-file-name-articles/-/remark-lint-no-file-name-articles-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-file-name-consecutive-dashes/-/remark-lint-no-file-name-consecutive-dashes-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-file-name-irregular-characters/-/remark-lint-no-file-name-irregular-characters-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-file-name-mixed-case/-/remark-lint-no-file-name-mixed-case-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-file-name-outer-dashes/-/remark-lint-no-file-name-outer-dashes-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-no-heading-punctuation/-/remark-lint-no-heading-punctuation-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-inline-padding/-/remark-lint-no-inline-padding-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-no-literal-urls/-/remark-lint-no-literal-urls-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-multiple-toplevel-headings/-/remark-lint-no-multiple-toplevel-headings-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-no-shell-dollars/-/remark-lint-no-shell-dollars-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-shortcut-reference-image/-/remark-lint-no-shortcut-reference-image-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-no-shortcut-reference-link/-/remark-lint-no-shortcut-reference-link-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-no-table-indentation/-/remark-lint-no-table-indentation-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-ordered-list-marker-style/-/remark-lint-ordered-list-marker-style-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-ordered-list-marker-value/-/remark-lint-ordered-list-marker-value-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-rule-style/-/remark-lint-rule-style-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-strong-marker/-/remark-lint-strong-marker-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-table-cell-padding/-/remark-lint-table-cell-padding-1.0.4.tgz
https://registry.yarnpkg.com/remark-lint-table-pipe-alignment/-/remark-lint-table-pipe-alignment-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-table-pipes/-/remark-lint-table-pipes-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint-unordered-list-marker-style/-/remark-lint-unordered-list-marker-style-1.0.3.tgz
https://registry.yarnpkg.com/remark-lint/-/remark-lint-6.0.5.tgz
https://registry.yarnpkg.com/remark-message-control/-/remark-message-control-4.2.0.tgz
https://registry.yarnpkg.com/remark-parse/-/remark-parse-4.0.0.tgz
https://registry.yarnpkg.com/remark-preset-lint-markdown-style-guide/-/remark-preset-lint-markdown-style-guide-2.1.3.tgz
https://registry.yarnpkg.com/remark-stringify/-/remark-stringify-4.0.0.tgz
https://registry.yarnpkg.com/remark/-/remark-8.0.0.tgz
https://registry.yarnpkg.com/remove-trailing-separator/-/remove-trailing-separator-1.1.0.tgz
https://registry.yarnpkg.com/repeat-element/-/repeat-element-1.1.3.tgz
https://registry.yarnpkg.com/repeat-string/-/repeat-string-1.6.1.tgz
https://registry.yarnpkg.com/repeating/-/repeating-2.0.1.tgz
https://registry.yarnpkg.com/replace-ext/-/replace-ext-1.0.0.tgz
https://registry.yarnpkg.com/request/-/request-2.88.0.tgz
https://registry.yarnpkg.com/require-directory/-/require-directory-2.1.1.tgz
https://registry.yarnpkg.com/require-main-filename/-/require-main-filename-2.0.0.tgz
https://registry.yarnpkg.com/require-uncached/-/require-uncached-1.0.3.tgz
https://registry.yarnpkg.com/requireindex/-/requireindex-1.1.0.tgz
https://registry.yarnpkg.com/resolve-cwd/-/resolve-cwd-2.0.0.tgz
https://registry.yarnpkg.com/resolve-dir/-/resolve-dir-1.0.1.tgz
https://registry.yarnpkg.com/resolve-from/-/resolve-from-1.0.1.tgz
https://registry.yarnpkg.com/resolve-from/-/resolve-from-3.0.0.tgz
https://registry.yarnpkg.com/resolve-from/-/resolve-from-4.0.0.tgz
https://registry.yarnpkg.com/resolve-from/-/resolve-from-5.0.0.tgz
https://registry.yarnpkg.com/resolve-url/-/resolve-url-0.2.1.tgz
https://registry.yarnpkg.com/resolve/-/resolve-1.11.1.tgz
https://registry.yarnpkg.com/restore-cursor/-/restore-cursor-1.0.1.tgz
https://registry.yarnpkg.com/restore-cursor/-/restore-cursor-2.0.0.tgz
https://registry.yarnpkg.com/ret/-/ret-0.1.15.tgz
https://registry.yarnpkg.com/rimraf/-/rimraf-2.2.8.tgz
https://registry.yarnpkg.com/rimraf/-/rimraf-2.6.3.tgz
https://registry.yarnpkg.com/ripemd160/-/ripemd160-2.0.2.tgz
https://registry.yarnpkg.com/run-async/-/run-async-2.3.0.tgz
https://registry.yarnpkg.com/run-node/-/run-node-1.0.0.tgz
https://registry.yarnpkg.com/run-parallel/-/run-parallel-1.1.9.tgz
https://registry.yarnpkg.com/run-queue/-/run-queue-1.0.3.tgz
https://registry.yarnpkg.com/rxjs/-/rxjs-5.5.12.tgz
https://registry.yarnpkg.com/rxjs/-/rxjs-6.5.2.tgz
https://registry.yarnpkg.com/rxjs/-/rxjs-6.5.3.tgz
https://registry.yarnpkg.com/safe-buffer/-/safe-buffer-5.1.2.tgz
https://registry.yarnpkg.com/safe-buffer/-/safe-buffer-5.2.0.tgz
https://registry.yarnpkg.com/safe-regex/-/safe-regex-1.1.0.tgz
https://registry.yarnpkg.com/safer-buffer/-/safer-buffer-2.1.2.tgz
https://registry.yarnpkg.com/sax/-/sax-1.2.4.tgz
https://registry.yarnpkg.com/schema-utils/-/schema-utils-1.0.0.tgz
https://registry.yarnpkg.com/schema-utils/-/schema-utils-2.7.0.tgz
https://registry.yarnpkg.com/semver-compare/-/semver-compare-1.0.0.tgz
https://registry.yarnpkg.com/semver/-/semver-5.7.0.tgz
https://registry.yarnpkg.com/semver/-/semver-5.7.1.tgz
https://registry.yarnpkg.com/semver/-/semver-6.2.0.tgz
https://registry.yarnpkg.com/semver/-/semver-6.3.0.tgz
https://registry.yarnpkg.com/send/-/send-0.17.1.tgz
https://registry.yarnpkg.com/serialize-javascript/-/serialize-javascript-3.1.0.tgz
https://registry.yarnpkg.com/serve-static/-/serve-static-1.14.1.tgz
https://registry.yarnpkg.com/set-blocking/-/set-blocking-2.0.0.tgz
https://registry.yarnpkg.com/set-value/-/set-value-2.0.1.tgz
https://registry.yarnpkg.com/setimmediate/-/setimmediate-1.0.5.tgz
https://registry.yarnpkg.com/setprototypeof/-/setprototypeof-1.1.1.tgz
https://registry.yarnpkg.com/sha.js/-/sha.js-2.4.11.tgz
https://registry.yarnpkg.com/shebang-command/-/shebang-command-1.2.0.tgz
https://registry.yarnpkg.com/shebang-regex/-/shebang-regex-1.0.0.tgz
https://registry.yarnpkg.com/shelljs/-/shelljs-0.8.3.tgz
https://registry.yarnpkg.com/shellsubstitute/-/shellsubstitute-1.2.0.tgz
https://registry.yarnpkg.com/shx/-/shx-0.3.2.tgz
https://registry.yarnpkg.com/signal-exit/-/signal-exit-3.0.2.tgz
https://registry.yarnpkg.com/simple-git/-/simple-git-1.118.0.tgz
https://registry.yarnpkg.com/single-line-log/-/single-line-log-1.1.2.tgz
https://registry.yarnpkg.com/slash/-/slash-1.0.0.tgz
https://registry.yarnpkg.com/slash/-/slash-3.0.0.tgz
https://registry.yarnpkg.com/slice-ansi/-/slice-ansi-0.0.4.tgz
https://registry.yarnpkg.com/slice-ansi/-/slice-ansi-1.0.0.tgz
https://registry.yarnpkg.com/slice-ansi/-/slice-ansi-2.1.0.tgz
https://registry.yarnpkg.com/sliced/-/sliced-1.0.1.tgz
https://registry.yarnpkg.com/snapdragon-node/-/snapdragon-node-2.1.1.tgz
https://registry.yarnpkg.com/snapdragon-util/-/snapdragon-util-3.0.1.tgz
https://registry.yarnpkg.com/snapdragon/-/snapdragon-0.8.2.tgz
https://registry.yarnpkg.com/source-list-map/-/source-list-map-2.0.1.tgz
https://registry.yarnpkg.com/source-map-resolve/-/source-map-resolve-0.5.2.tgz
https://registry.yarnpkg.com/source-map-support/-/source-map-support-0.5.12.tgz
https://registry.yarnpkg.com/source-map-url/-/source-map-url-0.4.0.tgz
https://registry.yarnpkg.com/source-map/-/source-map-0.5.7.tgz
https://registry.yarnpkg.com/source-map/-/source-map-0.6.1.tgz
https://registry.yarnpkg.com/spdx-correct/-/spdx-correct-3.1.0.tgz
https://registry.yarnpkg.com/spdx-exceptions/-/spdx-exceptions-2.2.0.tgz
https://registry.yarnpkg.com/spdx-expression-parse/-/spdx-expression-parse-3.0.0.tgz
https://registry.yarnpkg.com/spdx-license-ids/-/spdx-license-ids-3.0.4.tgz
https://registry.yarnpkg.com/speedometer/-/speedometer-0.1.4.tgz
https://registry.yarnpkg.com/split-string/-/split-string-3.1.0.tgz
https://registry.yarnpkg.com/sprintf-js/-/sprintf-js-1.0.3.tgz
https://registry.yarnpkg.com/sshpk/-/sshpk-1.16.1.tgz
https://registry.yarnpkg.com/ssri/-/ssri-6.0.1.tgz
https://registry.yarnpkg.com/staged-git-files/-/staged-git-files-1.1.2.tgz
https://registry.yarnpkg.com/standard-engine/-/standard-engine-9.0.0.tgz
https://registry.yarnpkg.com/standard-markdown/-/standard-markdown-5.0.1.tgz
https://registry.yarnpkg.com/standard/-/standard-12.0.1.tgz
https://registry.yarnpkg.com/state-toggle/-/state-toggle-1.0.2.tgz
https://registry.yarnpkg.com/static-extend/-/static-extend-0.1.2.tgz
https://registry.yarnpkg.com/statuses/-/statuses-1.5.0.tgz
https://registry.yarnpkg.com/stream-browserify/-/stream-browserify-2.0.2.tgz
https://registry.yarnpkg.com/stream-each/-/stream-each-1.2.3.tgz
https://registry.yarnpkg.com/stream-http/-/stream-http-2.8.3.tgz
https://registry.yarnpkg.com/stream-shift/-/stream-shift-1.0.0.tgz
https://registry.yarnpkg.com/string-argv/-/string-argv-0.0.2.tgz
https://registry.yarnpkg.com/string-width/-/string-width-1.0.2.tgz
https://registry.yarnpkg.com/string-width/-/string-width-2.1.1.tgz
https://registry.yarnpkg.com/string-width/-/string-width-3.1.0.tgz
https://registry.yarnpkg.com/string_decoder/-/string_decoder-0.10.31.tgz
https://registry.yarnpkg.com/string_decoder/-/string_decoder-1.1.1.tgz
https://registry.yarnpkg.com/string_decoder/-/string_decoder-1.2.0.tgz
https://registry.yarnpkg.com/stringify-entities/-/stringify-entities-1.3.2.tgz
https://registry.yarnpkg.com/stringify-object/-/stringify-object-3.3.0.tgz
https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-3.0.1.tgz
https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-4.0.0.tgz
https://registry.yarnpkg.com/strip-ansi/-/strip-ansi-5.2.0.tgz
https://registry.yarnpkg.com/strip-bom/-/strip-bom-2.0.0.tgz
https://registry.yarnpkg.com/strip-bom/-/strip-bom-3.0.0.tgz
https://registry.yarnpkg.com/strip-eof/-/strip-eof-1.0.0.tgz
https://registry.yarnpkg.com/strip-indent/-/strip-indent-1.0.1.tgz
https://registry.yarnpkg.com/strip-json-comments/-/strip-json-comments-2.0.1.tgz
https://registry.yarnpkg.com/sumchecker/-/sumchecker-2.0.2.tgz
https://registry.yarnpkg.com/supports-color/-/supports-color-2.0.0.tgz
https://registry.yarnpkg.com/supports-color/-/supports-color-4.5.0.tgz
https://registry.yarnpkg.com/supports-color/-/supports-color-5.5.0.tgz
https://registry.yarnpkg.com/supports-color/-/supports-color-6.1.0.tgz
https://registry.yarnpkg.com/symbol-observable/-/symbol-observable-1.0.1.tgz
https://registry.yarnpkg.com/symbol-observable/-/symbol-observable-1.2.0.tgz
https://registry.yarnpkg.com/synchronous-promise/-/synchronous-promise-2.0.9.tgz
https://registry.yarnpkg.com/table/-/table-4.0.3.tgz
https://registry.yarnpkg.com/table/-/table-5.4.6.tgz
https://registry.yarnpkg.com/tap-parser/-/tap-parser-1.2.2.tgz
https://registry.yarnpkg.com/tap-xunit/-/tap-xunit-2.4.1.tgz
https://registry.yarnpkg.com/tapable/-/tapable-1.1.3.tgz
https://registry.yarnpkg.com/tar-fs/-/tar-fs-1.16.3.tgz
https://registry.yarnpkg.com/tar-stream/-/tar-stream-1.6.2.tgz
https://registry.yarnpkg.com/tar/-/tar-4.4.10.tgz
https://registry.yarnpkg.com/temp/-/temp-0.8.3.tgz
https://registry.yarnpkg.com/terser-webpack-plugin/-/terser-webpack-plugin-1.4.4.tgz
https://registry.yarnpkg.com/terser/-/terser-4.8.0.tgz
https://registry.yarnpkg.com/text-table/-/text-table-0.2.0.tgz
https://registry.yarnpkg.com/throttleit/-/throttleit-0.0.2.tgz
https://registry.yarnpkg.com/through/-/through-2.3.8.tgz
https://registry.yarnpkg.com/through2/-/through2-0.2.3.tgz
https://registry.yarnpkg.com/through2/-/through2-2.0.5.tgz
https://registry.yarnpkg.com/timed-out/-/timed-out-4.0.1.tgz
https://registry.yarnpkg.com/timers-browserify/-/timers-browserify-1.4.2.tgz
https://registry.yarnpkg.com/timers-browserify/-/timers-browserify-2.0.10.tgz
https://registry.yarnpkg.com/tmp-promise/-/tmp-promise-1.1.0.tgz
https://registry.yarnpkg.com/tmp/-/tmp-0.0.33.tgz
https://registry.yarnpkg.com/tmp/-/tmp-0.1.0.tgz
https://registry.yarnpkg.com/to-arraybuffer/-/to-arraybuffer-1.0.1.tgz
https://registry.yarnpkg.com/to-buffer/-/to-buffer-1.1.1.tgz
https://registry.yarnpkg.com/to-object-path/-/to-object-path-0.3.0.tgz
https://registry.yarnpkg.com/to-regex-range/-/to-regex-range-2.1.1.tgz
https://registry.yarnpkg.com/to-regex-range/-/to-regex-range-5.0.1.tgz
https://registry.yarnpkg.com/to-regex/-/to-regex-3.0.2.tgz
https://registry.yarnpkg.com/to-vfile/-/to-vfile-2.2.0.tgz
https://registry.yarnpkg.com/toidentifier/-/toidentifier-1.0.0.tgz
https://registry.yarnpkg.com/toposort/-/toposort-2.0.2.tgz
https://registry.yarnpkg.com/tough-cookie/-/tough-cookie-2.4.3.tgz
https://registry.yarnpkg.com/trim-newlines/-/trim-newlines-1.0.0.tgz
https://registry.yarnpkg.com/trim-trailing-lines/-/trim-trailing-lines-1.1.2.tgz
https://registry.yarnpkg.com/trim/-/trim-0.0.1.tgz
https://registry.yarnpkg.com/trough/-/trough-1.0.4.tgz
https://registry.yarnpkg.com/ts-loader/-/ts-loader-6.0.4.tgz
https://registry.yarnpkg.com/ts-node/-/ts-node-6.2.0.tgz
https://registry.yarnpkg.com/tslib/-/tslib-1.10.0.tgz
https://registry.yarnpkg.com/tsutils/-/tsutils-3.17.1.tgz
https://registry.yarnpkg.com/tty-browserify/-/tty-browserify-0.0.0.tgz
https://registry.yarnpkg.com/tunnel-agent/-/tunnel-agent-0.6.0.tgz
https://registry.yarnpkg.com/tweetnacl/-/tweetnacl-0.14.5.tgz
https://registry.yarnpkg.com/type-check/-/type-check-0.3.2.tgz
https://registry.yarnpkg.com/type-detect/-/type-detect-4.0.8.tgz
https://registry.yarnpkg.com/type-fest/-/type-fest-0.4.1.tgz
https://registry.yarnpkg.com/type-is/-/type-is-1.6.18.tgz
https://registry.yarnpkg.com/typedarray/-/typedarray-0.0.6.tgz
https://registry.yarnpkg.com/typescript/-/typescript-3.5.3.tgz
https://registry.yarnpkg.com/typescript/-/typescript-3.6.3.tgz
https://registry.yarnpkg.com/uc.micro/-/uc.micro-1.0.6.tgz
https://registry.yarnpkg.com/unherit/-/unherit-1.1.2.tgz
https://registry.yarnpkg.com/unified-args/-/unified-args-4.0.0.tgz
https://registry.yarnpkg.com/unified-engine/-/unified-engine-4.0.1.tgz
https://registry.yarnpkg.com/unified-lint-rule/-/unified-lint-rule-1.0.4.tgz
https://registry.yarnpkg.com/unified-message-control/-/unified-message-control-1.0.4.tgz
https://registry.yarnpkg.com/unified/-/unified-6.2.0.tgz
https://registry.yarnpkg.com/union-value/-/union-value-1.0.1.tgz
https://registry.yarnpkg.com/uniq/-/uniq-1.0.1.tgz
https://registry.yarnpkg.com/unique-filename/-/unique-filename-1.1.1.tgz
https://registry.yarnpkg.com/unique-slug/-/unique-slug-2.0.2.tgz
https://registry.yarnpkg.com/unist-util-generated/-/unist-util-generated-1.1.4.tgz
https://registry.yarnpkg.com/unist-util-is/-/unist-util-is-3.0.0.tgz
https://registry.yarnpkg.com/unist-util-position/-/unist-util-position-3.0.3.tgz
https://registry.yarnpkg.com/unist-util-remove-position/-/unist-util-remove-position-1.1.3.tgz
https://registry.yarnpkg.com/unist-util-stringify-position/-/unist-util-stringify-position-1.1.2.tgz
https://registry.yarnpkg.com/unist-util-stringify-position/-/unist-util-stringify-position-2.0.1.tgz
https://registry.yarnpkg.com/unist-util-visit-parents/-/unist-util-visit-parents-2.1.2.tgz
https://registry.yarnpkg.com/unist-util-visit/-/unist-util-visit-1.4.1.tgz
https://registry.yarnpkg.com/universal-github-app-jwt/-/universal-github-app-jwt-1.1.0.tgz
https://registry.yarnpkg.com/universal-user-agent/-/universal-user-agent-2.1.0.tgz
https://registry.yarnpkg.com/universal-user-agent/-/universal-user-agent-6.0.0.tgz
https://registry.yarnpkg.com/universalify/-/universalify-0.1.2.tgz
https://registry.yarnpkg.com/unpipe/-/unpipe-1.0.0.tgz
https://registry.yarnpkg.com/unset-value/-/unset-value-1.0.0.tgz
https://registry.yarnpkg.com/untildify/-/untildify-2.1.0.tgz
https://registry.yarnpkg.com/unzip-response/-/unzip-response-2.0.1.tgz
https://registry.yarnpkg.com/upath/-/upath-1.1.2.tgz
https://registry.yarnpkg.com/uri-js/-/uri-js-4.2.2.tgz
https://registry.yarnpkg.com/urix/-/urix-0.1.0.tgz
https://registry.yarnpkg.com/url-parse-lax/-/url-parse-lax-1.0.0.tgz
https://registry.yarnpkg.com/url-template/-/url-template-2.0.8.tgz
https://registry.yarnpkg.com/url/-/url-0.11.0.tgz
https://registry.yarnpkg.com/use/-/use-3.1.1.tgz
https://registry.yarnpkg.com/util-deprecate/-/util-deprecate-1.0.2.tgz
https://registry.yarnpkg.com/util/-/util-0.10.3.tgz
https://registry.yarnpkg.com/util/-/util-0.11.1.tgz
https://registry.yarnpkg.com/utils-merge/-/utils-merge-1.0.1.tgz
https://registry.yarnpkg.com/uuid/-/uuid-3.3.2.tgz
https://registry.yarnpkg.com/v8-compile-cache/-/v8-compile-cache-2.1.1.tgz
https://registry.yarnpkg.com/validate-npm-package-license/-/validate-npm-package-license-3.0.4.tgz
https://registry.yarnpkg.com/vary/-/vary-1.1.2.tgz
https://registry.yarnpkg.com/verror/-/verror-1.10.0.tgz
https://registry.yarnpkg.com/vfile-location/-/vfile-location-2.0.5.tgz
https://registry.yarnpkg.com/vfile-message/-/vfile-message-1.1.1.tgz
https://registry.yarnpkg.com/vfile-reporter/-/vfile-reporter-4.0.0.tgz
https://registry.yarnpkg.com/vfile-statistics/-/vfile-statistics-1.1.3.tgz
https://registry.yarnpkg.com/vfile/-/vfile-2.3.0.tgz
https://registry.yarnpkg.com/vm-browserify/-/vm-browserify-1.1.0.tgz
https://registry.yarnpkg.com/walk-sync/-/walk-sync-0.3.4.tgz
https://registry.yarnpkg.com/watchpack-chokidar2/-/watchpack-chokidar2-2.0.0.tgz
https://registry.yarnpkg.com/watchpack/-/watchpack-1.7.2.tgz
https://registry.yarnpkg.com/wcwidth/-/wcwidth-1.0.1.tgz
https://registry.yarnpkg.com/webpack-cli/-/webpack-cli-3.3.12.tgz
https://registry.yarnpkg.com/webpack-sources/-/webpack-sources-1.4.3.tgz
https://registry.yarnpkg.com/webpack/-/webpack-4.43.0.tgz
https://registry.yarnpkg.com/which-module/-/which-module-2.0.0.tgz
https://registry.yarnpkg.com/which/-/which-1.3.1.tgz
https://registry.yarnpkg.com/wide-align/-/wide-align-1.1.3.tgz
https://registry.yarnpkg.com/windows-release/-/windows-release-3.2.0.tgz
https://registry.yarnpkg.com/wordwrap/-/wordwrap-0.0.3.tgz
https://registry.yarnpkg.com/wordwrap/-/wordwrap-1.0.0.tgz
https://registry.yarnpkg.com/worker-farm/-/worker-farm-1.7.0.tgz
https://registry.yarnpkg.com/wrap-ansi/-/wrap-ansi-3.0.1.tgz
https://registry.yarnpkg.com/wrap-ansi/-/wrap-ansi-5.1.0.tgz
https://registry.yarnpkg.com/wrapped/-/wrapped-1.0.1.tgz
https://registry.yarnpkg.com/wrappy/-/wrappy-1.0.2.tgz
https://registry.yarnpkg.com/write/-/write-0.2.1.tgz
https://registry.yarnpkg.com/write/-/write-1.0.3.tgz
https://registry.yarnpkg.com/x-is-function/-/x-is-function-1.0.4.tgz
https://registry.yarnpkg.com/x-is-string/-/x-is-string-0.1.0.tgz
https://registry.yarnpkg.com/xmlbuilder/-/xmlbuilder-4.2.1.tgz
https://registry.yarnpkg.com/xtend/-/xtend-2.1.2.tgz
https://registry.yarnpkg.com/xtend/-/xtend-4.0.2.tgz
https://registry.yarnpkg.com/y18n/-/y18n-4.0.0.tgz
https://registry.yarnpkg.com/yallist/-/yallist-3.0.3.tgz
https://registry.yarnpkg.com/yallist/-/yallist-4.0.0.tgz
https://registry.yarnpkg.com/yargs-parser/-/yargs-parser-13.1.2.tgz
https://registry.yarnpkg.com/yargs/-/yargs-13.3.2.tgz
https://registry.yarnpkg.com/yn/-/yn-2.0.0.tgz
https://registry.yarnpkg.com/yup/-/yup-0.27.0.tgz
"

SRC_URI="
	https://commondatastorage.googleapis.com/chromium-browser-official/${CHROMIUM_P}.tar.xz
	https://github.com/electron/electron/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/nodejs/node/archive/v${NODE_VERSION}.tar.gz -> electron-${NODE_P}.tar.gz
	https://files.pythonhosted.org/packages/ed/7b/bbf89ca71e722b7f9464ebffe4b5ee20a9e5c9a555a56e2d3914bb9119a6/setuptools-44.1.0.zip
	$(yarn_uris ${YARNPKGS})
"

CHROMIUM_S="${WORKDIR}/${CHROMIUM_P}"
NODE_S="${CHROMIUM_S}/third_party/electron_node"
ROOT_S="${WORKDIR}/src"

LICENSE="BSD"
SLOT="9"
KEYWORDS="~amd64"
IUSE="atk custom-cflags lto X pipewire pgo
	component-build cups cpu_flags_arm_neon headless kerberos ozone pic +proprietary-codecs
	pulseaudio selinux +suid +system-ffmpeg +system-icu +system-libvpx +tcmalloc wayland"
RESTRICT="!system-ffmpeg? ( proprietary-codecs? ( bindist ) ) mirror"
REQUIRED_USE="
	component-build? ( !suid )
	wayland? ( ozone )"

COMMON_X_DEPEND="
	media-libs/mesa:=[gbm]
	x11-libs/libX11:=
	x11-libs/libXcomposite:=
	x11-libs/libXcursor:=
	x11-libs/libXdamage:=
	x11-libs/libXext:=
	x11-libs/libXfixes:=
	>=x11-libs/libXi-1.6.0:=
	x11-libs/libXrandr:=
	x11-libs/libXrender:=
	x11-libs/libXtst:=
	x11-libs/libXScrnSaver:=
	x11-libs/libxcb:=
"

COMMON_DEPEND="
	app-arch/bzip2:=
	cups? ( >=net-print/cups-1.3.11:= )
	dev-libs/expat:=
	dev-libs/glib:2
	>=dev-libs/libxml2-2.9.4-r3:=[icu]
	dev-libs/nspr:=
	>=dev-libs/nss-3.26:=
	>=media-libs/alsa-lib-1.0.19:=
	media-libs/fontconfig:=
	media-libs/freetype:=
	>=media-libs/harfbuzz-2.4.0:0=[icu(-)]
	media-libs/libjpeg-turbo:=
	media-libs/libpng:=
	system-libvpx? ( >=media-libs/libvpx-1.8.2:=[postproc,svc] )
	pulseaudio? ( media-sound/pulseaudio:= )
	system-ffmpeg? (
		>=media-video/ffmpeg-4:=
		|| (
			media-video/ffmpeg[-samba]
			>=net-fs/samba-4.5.10-r1[-debug(-)]
		)
		>=media-libs/opus-1.3.1:=
	)
	sys-apps/dbus:=
	sys-apps/pciutils:=
	virtual/udev
	x11-libs/cairo:=
	x11-libs/gdk-pixbuf:2
	x11-libs/pango:=
	media-libs/flac:=
	>=media-libs/libwebp-0.4.0:=
	sys-libs/zlib:=[minizip]
	kerberos? ( virtual/krb5 )
	pipewire? ( media-video/pipewire:0/0.3 )
	ozone? (
		!headless? (
			${COMMON_X_DEPEND}
			x11-libs/gtk+:3[wayland?,X]
			wayland? (
				dev-libs/wayland:=
				dev-libs/libffi:=
				x11-libs/libdrm:=
				x11-libs/libxkbcommon:=
			)
		)
	)
	!ozone? (
		atk? (
			>=app-accessibility/at-spi2-atk-2.26:2
			>=app-accessibility/at-spi2-core-2.26:2
			>=dev-libs/atk-2.26
		)
		x11-libs/gtk+:3[X]
		${COMMON_X_DEPEND}
	)
	x11-libs/libnotify:=
	>=net-dns/c-ares-1.15.0
	>=net-libs/http-parser-2.9.0:=
	>=net-libs/nghttp2-1.39.2
	dev-libs/libevent:=
	>=dev-libs/openssl-1.1.1:0=
	app-eselect/eselect-electron
"
# For nvidia-drivers blocker, see bug #413637 .
RDEPEND="${COMMON_DEPEND}
	x11-misc/xdg-utils
	virtual/opengl
	virtual/ttf-fonts
	selinux? ( sec-policy/selinux-chromium )
	tcmalloc? ( !<x11-drivers/nvidia-drivers-331.20 )
"
DEPEND="${COMMON_DEPEND}
"
# dev-vcs/git - https://bugs.gentoo.org/593476
BDEPEND="
	${PYTHON_DEPS}
	>=app-arch/gzip-1.7
	app-arch/unzip
	dev-lang/perl
	>=dev-util/gn-0.1726
	dev-vcs/git
	>=dev-util/gperf-3.0.3
	>=dev-util/ninja-1.7.2
	>=net-libs/nodejs-7.6.0[inspector]
	sys-apps/hwids[usb(+)]
	>=sys-devel/bison-2.4.3
	sys-devel/flex
	virtual/pkgconfig
	!system-libvpx? (
		amd64? ( dev-lang/yasm )
		x86? ( dev-lang/yasm )
	)
"

: ${CHROMIUM_FORCE_CLANG=no}
: ${CHROMIUM_FORCE_LIBCXX=no}

if [[ ${CHROMIUM_FORCE_CLANG} == yes ]]; then
	BDEPEND+=" >=sys-devel/clang-9"
fi

if [[ ${CHROMIUM_FORCE_LIBCXX} == yes ]]; then
	RDEPEND+=" >=sys-libs/libcxx-9"
	DEPEND+=" >=sys-libs/libcxx-9"
	BDEPEND+="
		amd64? ( dev-lang/yasm )
		x86? ( dev-lang/yasm )
	"
else
	COMMON_DEPEND="
		app-arch/snappy:=
		dev-libs/libxslt:=
		>=dev-libs/re2-0.2019.08.01:=
		>=media-libs/openh264-1.6.0:=
		system-icu? ( >=dev-libs/icu-67.1:= )
	"
	RDEPEND+="${COMMON_DEPEND}"
	DEPEND+="${COMMON_DEPEND}"
fi

if ! has chromium_pkg_die ${EBUILD_DEATH_HOOKS}; then
	EBUILD_DEATH_HOOKS+=" chromium_pkg_die";
fi

pre_build_checks() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		local -x CPP="$(tc-getCXX) -E"
		if tc-is-gcc && ! ver_test "$(gcc-version)" -ge 8.0; then
			die "At least gcc 8.0 is required"
		fi
		# component build hangs with tcmalloc enabled due to sandbox issue, bug #695976.
		if has usersandbox ${FEATURES} && use tcmalloc && use component-build; then
			die "Component build with tcmalloc requires FEATURES=-usersandbox."
		fi
		if [[ ${CHROMIUM_FORCE_CLANG} == yes ]] || tc-is-clang; then
			if use component-build; then
				die "Component build with clang requires fuzzer headers."
			fi
		fi
	fi

	# Check build requirements, bug #541816 and bug #471810 .
	CHECKREQS_MEMORY="3G"
	CHECKREQS_DISK_BUILD="7G"
	if use lto || use pgo; then
		if ! tc-is-clang; then
			die "lto or pgo only support clang and lld"
		fi
		CHECKREQS_MEMORY="8G"
	fi
	if ( shopt -s extglob; is-flagq '-g?(gdb)?([1-9])' ); then
		if use custom-cflags || use component-build; then
			CHECKREQS_DISK_BUILD="25G"
		fi
		if ! use component-build; then
			CHECKREQS_MEMORY="16G"
		fi
	fi

	check-reqs_pkg_setup
}

pkg_pretend() {
	pre_build_checks
}

pkg_setup() {
	pre_build_checks

	chromium_suid_sandbox_check_kernel_config
}

_get_install_suffix() {
	local c=(${SLOT//\// })
	local slot=${c[0]}
	local suffix

	if [[ "${slot}" == "0" ]]; then
		suffix=""
	else
		suffix="-${slot}"
	fi

	echo -n "${suffix}"
}

_get_install_dir() {
	echo -n "/usr/$(get_libdir)/electron$(_get_install_suffix)"
}

src_unpack() {
	unpack "${CHROMIUM_P}.tar.xz"
	unpack "${P}.tar.gz"
	unpack "electron-${NODE_P}.tar.gz"
	unpack "setuptools-44.1.0.zip"
}

src_prepare() {
	# Calling this here supports resumption via FEATURES=keepwork
	python_setup

	default

	# Electron's scripts expect the top dir to be called src/"
	ln -s "${CHROMIUM_S}" "${ROOT_S}"
	mkdir -p "${NODE_S}/" || die
	rsync -a "${WORKDIR}/${NODE_P}/" "${NODE_S}/" || die

	echo "yarn-offline-mirror \"${DISTDIR}\"" >> ${S}/.yarnrc

	yarn install --ignore-optional --frozen-lockfile --offline \
		--ignore-scripts --no-progress --verbose || die

	ln -s "${S}/" "${CHROMIUM_S}/electron" || die

	# Apply Gentoo patches for Electron itself.
	cd "${CHROMIUM_S}/electron" || die

	cp -r "${FILESDIR}/${SLOT}/electron/" "${WORKDIR}/electron-patch"
	use ozone || rm -r "${WORKDIR}"/electron-patch/000*
	eapply ""${WORKDIR}"/electron-patch"

	# Apply Chromium patches from Electron.
	local patchespath repopath
	("${EPYTHON}" "${FILESDIR}/list_patch_targets.py" \
		"${S}/patches/config.json" || die) \
	| while read -r patchespath repopath; do
		einfo "Apply Electron's patches to ${repopath}"
		cd "${WORKDIR}/${repopath}" || die
		eapply "${WORKDIR}/${patchespath}"
	done

	cd "${CHROMIUM_S}" || die
	# Finally, apply Gentoo patches for Chromium.
	cp -r "${FILESDIR}/${SLOT}/chromium/" "${WORKDIR}/chromium-patch"
	use elibc_musl || rm -r "${WORKDIR}"/chromium-patch/musl*
	use ozone || rm -r "${WORKDIR}"/chromium-patch/ozone*
	eapply "${WORKDIR}"/chromium-patch

	mkdir -p third_party/node/linux/node-linux-x64/bin || die
	ln -s "${EPREFIX}"/usr/bin/node third_party/node/linux/node-linux-x64/bin/node || die

	local keeplibs=(
		third_party/electron_node
		base/third_party/cityhash
		base/third_party/double_conversion
		base/third_party/dynamic_annotations
		base/third_party/icu
		base/third_party/nspr
		base/third_party/superfasthash
		base/third_party/symbolize
		base/third_party/valgrind
		base/third_party/xdg_mime
		base/third_party/xdg_user_dirs
		buildtools/third_party/libc++
		buildtools/third_party/libc++abi
		chrome/third_party/mozilla_security_manager
		courgette/third_party
		net/third_party/mozilla_security_manager
		net/third_party/nss
		net/third_party/quic
		net/third_party/uri_template
		third_party/abseil-cpp
		third_party/angle
		third_party/angle/src/common/third_party/base
		third_party/angle/src/common/third_party/smhasher
		third_party/angle/src/common/third_party/xxhash
		third_party/angle/src/third_party/compiler
		third_party/angle/src/third_party/libXNVCtrl
		third_party/angle/src/third_party/trace_event
		third_party/angle/src/third_party/volk
		third_party/angle/third_party/glslang
		third_party/angle/third_party/spirv-headers
		third_party/angle/third_party/spirv-tools
		third_party/angle/third_party/vulkan-headers
		third_party/angle/third_party/vulkan-loader
		third_party/angle/third_party/vulkan-tools
		third_party/angle/third_party/vulkan-validation-layers
		third_party/apple_apsl
		third_party/axe-core
		third_party/blink
		third_party/boringssl
		third_party/boringssl/src/third_party/fiat
		third_party/breakpad
		third_party/breakpad/breakpad/src/third_party/curl
		third_party/brotli
		third_party/cacheinvalidation
		third_party/catapult
		third_party/catapult/common/py_vulcanize/third_party/rcssmin
		third_party/catapult/common/py_vulcanize/third_party/rjsmin
		third_party/catapult/third_party/beautifulsoup4
		third_party/catapult/third_party/html5lib-python
		third_party/catapult/third_party/polymer
		third_party/catapult/third_party/six
		third_party/catapult/tracing/third_party/d3
		third_party/catapult/tracing/third_party/gl-matrix
		third_party/catapult/tracing/third_party/jpeg-js
		third_party/catapult/tracing/third_party/jszip
		third_party/catapult/tracing/third_party/mannwhitneyu
		third_party/catapult/tracing/third_party/oboe
		third_party/catapult/tracing/third_party/pako
		third_party/ced
		third_party/cld_3
		third_party/closure_compiler
		third_party/crashpad
		third_party/crashpad/crashpad/third_party/lss
		third_party/crashpad/crashpad/third_party/zlib
		third_party/crc32c
		third_party/cros_system_api
		third_party/dav1d
		third_party/dawn
		third_party/depot_tools
		third_party/devscripts
		third_party/devtools-frontend
		third_party/devtools-frontend/src/front_end/third_party/fabricjs
		third_party/devtools-frontend/src/front_end/third_party/lighthouse
		third_party/devtools-frontend/src/front_end/third_party/wasmparser
		third_party/devtools-frontend/src/third_party
		third_party/dom_distiller_js
		third_party/emoji-segmenter
		third_party/flatbuffers
		third_party/freetype
		third_party/libgifcodec
		third_party/glslang
		third_party/google_input_tools
		third_party/google_input_tools/third_party/closure_library
		third_party/google_input_tools/third_party/closure_library/third_party/closure
		third_party/googletest
		third_party/harfbuzz-ng/utils
		third_party/hunspell
		third_party/iccjpeg
		third_party/inspector_protocol
		third_party/jinja2
		third_party/jsoncpp
		third_party/jstemplate
		third_party/khronos
		third_party/leveldatabase
		third_party/libXNVCtrl
		third_party/libaddressinput
		third_party/libaom
		third_party/libaom/source/libaom/third_party/vector
		third_party/libaom/source/libaom/third_party/x86inc
		third_party/libjingle
		third_party/libphonenumber
		third_party/libsecret
		third_party/libsrtp
		third_party/libsync
		third_party/libudev
		third_party/libwebm
		third_party/libxml/chromium
		third_party/libyuv
		third_party/llvm
		third_party/lss
		third_party/lzma_sdk
		third_party/mako
		third_party/markupsafe
		third_party/mesa
		third_party/metrics_proto
		third_party/modp_b64
		third_party/nasm
		third_party/node
		third_party/node/node_modules/polymer-bundler/lib/third_party/UglifyJS2
		third_party/one_euro_filter
		third_party/openscreen
		third_party/openscreen/src/third_party/tinycbor/src/src
		third_party/ots
		third_party/pdfium
		third_party/pdfium/third_party/agg23
		third_party/pdfium/third_party/base
		third_party/pdfium/third_party/bigint
		third_party/pdfium/third_party/freetype
		third_party/pdfium/third_party/lcms
		third_party/pdfium/third_party/libopenjpeg20
		third_party/pdfium/third_party/libpng16
		third_party/pdfium/third_party/libtiff
		third_party/pdfium/third_party/skia_shared
		third_party/perfetto
		third_party/pffft
		third_party/ply
		third_party/polymer
		third_party/private-join-and-compute
		third_party/protobuf
		third_party/protobuf/third_party/six
		third_party/pyjson5
		third_party/qcms
		third_party/rnnoise
		third_party/s2cellid
		third_party/schema_org
		third_party/simplejson
		third_party/skia
		third_party/skia/include/third_party/skcms
		third_party/skia/include/third_party/vulkan
		third_party/skia/third_party/skcms
		third_party/skia/third_party/vulkan
		third_party/smhasher
		third_party/spirv-headers
		third_party/SPIRV-Tools
		third_party/sqlite
		third_party/swiftshader
		third_party/swiftshader/third_party/marl
		third_party/swiftshader/third_party/astc-encoder
		third_party/swiftshader/third_party/subzero
		third_party/swiftshader/third_party/llvm-7.0
		third_party/swiftshader/third_party/llvm-subzero
		third_party/swiftshader/third_party/SPIRV-Headers/include/spirv/unified1
		third_party/unrar
		third_party/usrsctp
		third_party/vulkan
		third_party/web-animations-js
		third_party/webdriver
		third_party/webrtc
		third_party/webrtc/common_audio/third_party/fft4g
		third_party/webrtc/common_audio/third_party/spl_sqrt_floor
		third_party/webrtc/modules/third_party/fft
		third_party/webrtc/modules/third_party/g711
		third_party/webrtc/modules/third_party/g722
		third_party/webrtc/rtc_base/third_party/base64
		third_party/webrtc/rtc_base/third_party/sigslot
		third_party/widevine
		third_party/woff2
		third_party/wuffs
		third_party/zlib/google
		tools/grit/third_party/six
		url/third_party/mozilla
		v8/src/third_party/siphash
		v8/src/third_party/valgrind
		v8/src/third_party/utf8-decoder
		v8/third_party/inspector_protocol
		v8/third_party/v8

		# gyp -> gn leftovers
		base/third_party/libevent
		third_party/adobe
		third_party/speech-dispatcher
		third_party/usb_ids
		third_party/xdg-utils
		third_party/yasm/run_yasm.py
	)
	if ! use system-ffmpeg; then
		keeplibs+=( third_party/ffmpeg third_party/opus )
	fi
	if ! use system-icu; then
		keeplibs+=( third_party/icu )
	fi
	if ! use system-libvpx; then
		keeplibs+=( third_party/libvpx )
		keeplibs+=( third_party/libvpx/source/libvpx/third_party/x86inc )

		# we need to generate ppc64 stuff because upstream does not ship it yet
		# it has to be done before unbundling.
		if use ppc64; then
			pushd third_party/libvpx >/dev/null || die
			mkdir -p source/config/linux/ppc64 || die
			./generate_gni.sh || die
			popd >/dev/null || die
		fi
	fi
	if use tcmalloc; then
		keeplibs+=( third_party/tcmalloc )
	fi
	if use ozone && use wayland && ! use headless ; then
		keeplibs+=( third_party/wayland )
	fi
	if [[ ${CHROMIUM_FORCE_LIBCXX} == yes ]]; then
		keeplibs+=( third_party/libxml )
		keeplibs+=( third_party/libxslt )
		keeplibs+=( third_party/openh264 )
		keeplibs+=( third_party/re2 )
		keeplibs+=( third_party/snappy )
		if use system-icu; then
			keeplibs+=( third_party/icu )
		fi
	fi

	ebegin "Remove bundled libraries"
	# Remove most bundled libraries. Some are still needed.
	build/linux/unbundle/remove_bundled_libraries.py "${keeplibs[@]}" --do-remove || die
	eend

	eapply_user
}

src_configure() {
	# Calling this here supports resumption via FEATURES=keepwork
	python_setup

	local myconf_gn=""

	# Make sure the build system will use the right tools, bug #340795.
	tc-export AR CC CXX NM

	cd "${CHROMIUM_S}" || die

	if [[ ${CHROMIUM_FORCE_CLANG} == yes ]] && ! tc-is-clang; then
		# Force clang since gcc is pretty broken at the moment.
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
		strip-unsupported-flags
	fi

	if tc-is-clang; then
		myconf_gn+=" is_clang=true clang_use_chrome_plugins=false"
	else
		if [[ ${CHROMIUM_FORCE_LIBCXX} == yes ]]; then
			die "Compiling with sys-libs/libcxx requires clang."
		fi
		myconf_gn+=" is_clang=false"
	fi

	# Define a custom toolchain for GN
	myconf_gn+=" custom_toolchain=\"//build/toolchain/linux/unbundle:default\""

	if tc-is-cross-compiler; then
		tc-export BUILD_{AR,CC,CXX,NM}
		myconf_gn+=" host_toolchain=\"//build/toolchain/linux/unbundle:host\""
		myconf_gn+=" v8_snapshot_toolchain=\"//build/toolchain/linux/unbundle:host\""
	else
		myconf_gn+=" host_toolchain=\"//build/toolchain/linux/unbundle:default\""
	fi

	# GN needs explicit config for Debug/Release as opposed to inferring it from build directory.
	myconf_gn+=" is_debug=false"
	myconf_gn+=" symbol_level=1"
	myconf_gn+=" blink_symbol_level=0"

	# Component build isn't generally intended for use by end users. It's mostly useful
	# for development and debugging.
	myconf_gn+=" is_component_build=$(usex component-build true false)"

	if use elibc_musl;then
		if use tcmalloc; then
			die "tcmalloc is broken with musl at this moment."
		fi
		myconf_gn+=" use_allocator_shim=false"
	fi

	myconf_gn+=" use_allocator=$(usex tcmalloc \"tcmalloc\" \"none\")"

	# Disable nacl, we can't build without pnacl (http://crbug.com/269560).
	myconf_gn+=" enable_nacl=false"

	# Use system-provided libraries.
	# TODO: freetype -- remove sources (https://bugs.chromium.org/p/pdfium/issues/detail?id=733).
	# TODO: use_system_hunspell (upstream changes needed).
	# TODO: use_system_libsrtp (bug #459932).
	# TODO: use_system_protobuf (bug #525560).
	# TODO: use_system_ssl (http://crbug.com/58087).
	# TODO: use_system_sqlite (http://crbug.com/22208).

	# libevent: https://bugs.gentoo.org/593458
	local gn_system_libraries=(
		flac
		fontconfig
		freetype
		# Need harfbuzz_from_pkgconfig target
		#harfbuzz-ng
		libdrm
		libjpeg
		libpng
		libwebp
		yasm
		zlib
	)
	if use system-ffmpeg; then
		gn_system_libraries+=( ffmpeg opus )
	fi
	if use system-icu; then
		gn_system_libraries+=( icu )
	fi
	if use system-libvpx; then
		gn_system_libraries+=( libvpx )
	fi
	if [[ ${CHROMIUM_FORCE_LIBCXX} != yes ]]; then
		# unbundle only without libc++, because libc++ is not fully ABI compatible with libstdc++
		gn_system_libraries+=( libxml )
		gn_system_libraries+=( libxslt )
		gn_system_libraries+=( openh264 )
		gn_system_libraries+=( re2 )
		gn_system_libraries+=( snappy )
	fi
	build/linux/unbundle/replace_gn_files.py --system-libraries "${gn_system_libraries[@]}" || die

	# See dependency logic in third_party/BUILD.gn
	myconf_gn+=" use_system_harfbuzz=true"

	# Disable deprecated libgnome-keyring dependency, bug #713012
	myconf_gn+=" use_gnome_keyring=false"

	# Optional dependencies.
	myconf_gn+=" use_cups=$(usex cups true false)"
	myconf_gn+=" use_kerberos=$(usex kerberos true false)"
	myconf_gn+=" use_pulseaudio=$(usex pulseaudio true false)"
	myconf_gn+=" use_atk=$(usex atk true false)"
	myconf_gn+=" rtc_use_pipewire=$(usex pipewire true false)"
	if use pipewire; then
        myconf_gn+=" rtc_link_pipewire=true"
        myconf_gn+=" rtc_use_pipewire_version=\"0.3\""
	fi
	myconf_gn+=" use_glib=true"

	# TODO: link_pulseaudio=true for GN.

	myconf_gn+=" fieldtrial_testing_like_official_build=true"

	# Never use bundled gold binary. Disable gold linker flags for now.
	# Do not use bundled clang.
	# Trying to use gold results in linker crash.
	myconf_gn+=" use_gold=false use_sysroot=false linux_use_bundled_binutils=false use_custom_libcxx=false"

	if use lto; then
		myconf_gn+=" use_thin_lto=true"
		myconf_gn+=" use_lld=true"
		myconf_gn+=" thin_lto_enable_optimizations=true"
	else
		# Disable forced lld, bug 641556
		myconf_gn+=" use_lld=false"
	fi

	if use pgo; then
		myconf_gn+=" clang_use_default_sample_profile=true"
	fi

	ffmpeg_branding="$(usex proprietary-codecs Chrome Chromium)"
	myconf_gn+=" proprietary_codecs=$(usex proprietary-codecs true false)"
	myconf_gn+=" ffmpeg_branding=\"${ffmpeg_branding}\""

	# Set up Google API keys, see http://www.chromium.org/developers/how-tos/api-keys .
	# Note: these are for Gentoo use ONLY. For your own distribution,
	# please get your own set of keys. Feel free to contact chromium@gentoo.org
	# for more info.
	local google_api_key="AIzaSyDEAOvatFo0eTgsV_ZlEzx0ObmepsMzfAc"
	local google_default_client_id="329227923882.apps.googleusercontent.com"
	local google_default_client_secret="vgKG0NNv7GoDpbtoFNLxCUXu"
	myconf_gn+=" google_api_key=\"${google_api_key}\""
	myconf_gn+=" google_default_client_id=\"${google_default_client_id}\""
	myconf_gn+=" google_default_client_secret=\"${google_default_client_secret}\""
	local myarch="$(tc-arch)"

	# Avoid CFLAGS problems, bug #352457, bug #390147.
	if ! use custom-cflags; then
		replace-flags "-Os" "-O2"
		strip-flags

		# Debug info section overflows without component build
		# Prevent linker from running out of address space, bug #471810 .
		if ! use component-build || use x86; then
			filter-flags "-g*"
		fi

		# Prevent libvpx build failures. Bug 530248, 544702, 546984.
		if [[ ${myarch} == amd64 || ${myarch} == x86 ]]; then
			filter-flags -mno-mmx -mno-sse2 -mno-ssse3 -mno-sse4.1 -mno-avx -mno-avx2 -mno-fma -mno-fma4
		fi
	fi

	if [[ ${CHROMIUM_FORCE_LIBCXX} == yes ]]; then
		append-flags -stdlib=libc++
		append-ldflags -stdlib=libc++
	fi

	if [[ $myarch = amd64 ]] ; then
		myconf_gn+=" target_cpu=\"x64\""
		ffmpeg_target_arch=x64
	elif [[ $myarch = x86 ]] ; then
		myconf_gn+=" target_cpu=\"x86\""
		ffmpeg_target_arch=ia32

		# This is normally defined by compiler_cpu_abi in
		# build/config/compiler/BUILD.gn, but we patch that part out.
		append-flags -msse2 -mfpmath=sse -mmmx
	elif [[ $myarch = arm64 ]] ; then
		myconf_gn+=" target_cpu=\"arm64\""
		ffmpeg_target_arch=arm64
	elif [[ $myarch = arm ]] ; then
		myconf_gn+=" target_cpu=\"arm\""
		ffmpeg_target_arch=$(usex cpu_flags_arm_neon arm-neon arm)
	elif [[ $myarch = ppc64 ]] ; then
		myconf_gn+=" target_cpu=\"ppc64\""
		ffmpeg_target_arch=ppc64
	else
		die "Failed to determine target arch, got '$myarch'."
	fi

	# Make sure that -Werror doesn't get added to CFLAGS by the build system.
	# Depending on GCC version the warnings are different and we don't want
	# the build to fail because of that.
	myconf_gn+=" treat_warnings_as_errors=false"

	# Disable fatal linker warnings, bug 506268.
	myconf_gn+=" fatal_linker_warnings=false"

	# Bug 491582.
	export TMPDIR="${WORKDIR}/temp"
	mkdir -p -m 755 "${TMPDIR}" || die

	# https://bugs.gentoo.org/654216
	addpredict /dev/dri/ #nowarn

	if ! use system-ffmpeg; then
	# if false; then #FIXME: why chromium ebuild have this?
		local build_ffmpeg_args=""
		if use pic && [[ "${ffmpeg_target_arch}" == "ia32" ]]; then
			build_ffmpeg_args+=" --disable-asm"
		fi

		# Re-configure bundled ffmpeg. See bug #491378 for example reasons.
		einfo "Configuring bundled ffmpeg..."
		pushd third_party/ffmpeg > /dev/null || die
		chromium/scripts/build_ffmpeg.py linux ${ffmpeg_target_arch} \
			--branding ${ffmpeg_branding} -- ${build_ffmpeg_args} || die
		chromium/scripts/copy_config.sh || die
		chromium/scripts/generate_gn.py || die
		popd > /dev/null || die
	fi

	# Chromium relies on this, but was disabled in >=clang-10, crbug.com/1042470
	append-cxxflags $(test-flags-CXX -flax-vector-conversions=all)

	# Explicitly disable ICU data file support for system-icu builds.
	if use system-icu; then
		myconf_gn+=" icu_use_data_file=false"
	fi

	# Enable ozone support
	if use ozone; then
		myconf_gn+=" use_ozone=true ozone_auto_platforms=false"
		myconf_gn+=" ozone_platform_headless=true"
		if ! use headless; then
			myconf_gn+=" use_system_libdrm=true"
			myconf_gn+=" ozone_platform_wayland=$(usex wayland true false)"
			myconf_gn+=" ozone_platform_x11=$(usex X true false)"
			myconf_gn+=" ozone_platform_headless=true"
			if use wayland; then
				myconf_gn+=" use_system_minigbm=true use_xkbcommon=true"
				myconf_gn+=" use_system_libwayland=true"
			fi
			if use X; then
				myconf_gn+=" ozone_platform=\"x11\""
			else
				myconf_gn+=" ozone_platform=\"wayland\""
			fi
		else
			myconf_gn+=" ozone_platform=\"headless\""
		fi
	fi

	# This configutation can generate config.gypi
	einfo "Configuring bundled nodejs..."
	pushd "${NODE_S}" > /dev/null || die
	# --shared-libuv cannot be used as electron's node fork
	# patches uv_loop structure.
	local nodeconf=(
		--shared
		--without-bundled-v8
		--shared-openssl
		--shared-http-parser
		--shared-zlib
		--shared-nghttp2
		--shared-cares
		--without-npm
		--without-dtrace
	)

	use system-icu && nodeconf+=( --with-intl=system-icu ) || nodeconf+=( --with-intl=none )

	local nodearch=""
	case ${ABI} in
		amd64) nodearch="x64";;
		arm) nodearch="arm";;
		arm64) nodearch="arm64";;
		ppc64) nodearch="ppc64";;
		x32) nodearch="x32";;
		x86) nodearch="ia32";;
		*) nodearch="${ABI}";;
	esac

	"${EPYTHON}" configure.py \
	--prefix="" \
	--dest-cpu=${nodearch} \
	"${nodeconf[@]}" || die

	popd > /dev/null || die

	myconf_gn+=" import(\"//electron/build/args/release.gn\")"

	einfo "Configuring Electron..."
	set -- gn gen --args="${myconf_gn} ${EXTRA_GN}" out/Release
	echo "$@"
	"$@" || die
}

src_compile() {
	# Final link uses lots of file descriptors.
	ulimit -n 2048

	# Calling this here supports resumption via FEATURES=keepwork
	python_setup

	# https://bugs.gentoo.org/717456
	local -x PYTHONPATH="${WORKDIR}/setuptools-44.1.0${PYTHONPATH+:}${PYTHONPATH}"

	cd "${CHROMIUM_S}" || die

	eninja -C out/Release third_party/electron_node:headers

	# FIXME: mksnapshot and v8_context_snapshot_generator will link twice (with clang lld ccache)
	# Build mksnapshot and pax-mark it.
	#local x
	#for x in mksnapshot v8_context_snapshot_generator; do
	#	if tc-is-cross-compiler; then
	#		eninja -C out/Release "host/${x}"
	#		pax-mark m "out/Release/host/${x}"
	#	else
	#		eninja -C out/Release "${x}"
	#		pax-mark m "out/Release/${x}"
	#	fi
	#done

	# Even though ninja autodetects number of CPUs, we respect
	# user's options, for debugging with -j 1 or any other reason.
	eninja -C out/Release electron chromedriver

	use suid && eninja -C out/Release chrome_sandbox

	pax-mark m out/Release/electron
}

src_install() {
	local install_dir="$(_get_install_dir)"
	local install_suffix="$(_get_install_suffix)"
	local LIBDIR="${ED}/usr/$(get_libdir)"

	cd "${CHROMIUM_S}" || die

	pushd out/Release/locales > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	# Install Electron
	insinto "${install_dir}"
	exeinto "${install_dir}"
	doexe out/Release/electron
	doexe out/Release/chromedriver
	doexe out/Release/mksnapshot
	doexe out/Release/crashpad_handler
	if use suid; then
		newexe out/Release/chrome_sandbox chrome-sandbox
		fperms 4755 "${install_dir}"/chrome-sandbox
	fi

	# 0644
	doins out/Release/snapshot_blob.bin
	doins out/Release/v8_context_snapshot.bin
	doins out/Release/chrome_100_percent.pak
	doins out/Release/chrome_200_percent.pak
	doins out/Release/resources.pak

	if ! use system-icu; then
		doins out/Release/icudtl.dat
	fi

	doins -r out/Release/resources

	doins -r "${NODE_S}/deps/npm"

	fperms -R 755 "${install_dir}/npm/bin/"

	echo "${PV}" > out/Release/version
	doins out/Release/version

	insinto "${install_dir}"/locales
	doins out/Release/locales/*.pak

	insopts -m755
	insinto "${install_dir}"/swiftshader
	doins out/Release/swiftshader/libEGL.so
	doins out/Release/swiftshader/libGLESv2.so

	insinto "${install_dir}"
	if ! use system-ffmpeg; then
		doins out/Release/libffmpeg.so
	fi

	doins out/Release/libvk_swiftshader.so

	if ! use ozone; then
		doins out/Release/libEGL.so
		doins out/Release/libGLESv2.so
		insopts -m644
		doins out/Release/vk_swiftshader_icd.json
	fi

	cat >out/Release/node <<EOF
#!/bin/sh
exec env ELECTRON_RUN_AS_NODE=1 "${install_dir}/electron" "\${@}"
EOF
	doexe out/Release/node

	# Install Node headers
	insopts -m644
	local node_headers="/usr/include/electron${install_suffix}"
	insinto "${node_headers}"
	doins -r out/Release/gen/node_headers/include/node
	# set up a symlink structure that npm expects..
	dodir "${node_headers}"/node/deps/{v8,uv}
	dosym . "${node_headers}"/node/src
	for var in deps/{uv,v8}/include; do
		dosym ../.. "${node_headers}"/node/${var}
	done

	dosym "${install_dir}/electron" "/usr/bin/electron${install_suffix}"
}

pkg_postinst() {
	electron-config update
}

pkg_postrm() {
	electron-config update
}
