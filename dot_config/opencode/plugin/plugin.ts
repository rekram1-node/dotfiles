import type { Plugin } from "@opencode-ai/plugin";

export const Notify: Plugin = async ({ client, $ }) => {
  return {
    // "chat.params": async (input, output) => {
    //   if (
    //     input.provider.id === "databricks" &&
    //     input.model.id.includes("claude")
    //   ) {
    //     output.options["includeUsage"] = false;
    //   }
    // },
    async event({ event }) {
      switch (event.type) {
        case "session.idle":
          await client.tui.showToast({
            body: {
              title: "[debug] event",
              message: event.type,
              variant: "info",
            },
          });
          break;
        // case "session.status": {
        //   if (event.properties.status.type === "idle") {
        //     await client.tui.showToast({
        //       body: {
        //         title: "[debug] event",
        //         message: event.type,
        //         variant: "info",
        //       },
        //     });
        //   }
        //   break;
        // }
        // default: {
        //   break;
        // }
      }
    },
  };
};
