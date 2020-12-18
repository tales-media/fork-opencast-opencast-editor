/**
 * A place for global config values
 */
import TOML from '@iarna/toml';
// var fs = require('fs')
import fs from 'fs'


/**
 * Hardcoded id of the mediapackge the editor will work on
 */


export var mediaPackageId : string = "e63706bc-48df-4346-a72a-bf6f39cea32c"
var urlParams = new URLSearchParams(window.location.search);
if (urlParams.has("mediaPackageId")) {
  let tmp = urlParams.get("mediaPackageId")
  if (tmp) {
    mediaPackageId = tmp
  }
}

 var test = parse("./editor-settings.toml")

function parse(configPath: string) {
  if (!fs.existsSync(configPath)) {
   throw new Error(`config file not found: ${configPath}`);
  }
  try {
   return TOML.parse(fs.readFileSync(configPath));
  } catch (err) {
   throw new Error(`config file parse failed: ${configPath}`);
  }
 }