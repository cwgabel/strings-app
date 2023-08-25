import { Client, QueryResult } from "pg";
import { loadEnvConfig } from "@next/env";

const projectDir = process.cwd();
loadEnvConfig(projectDir);

export async function getClient(): Promise<Client> {
  if (process.env.POSTGRES_URL) {
    const client = new Client({
      connectionString: process.env.POSTGRES_URL + "?sslmode=require",
    });
    return client;
  }
   const client = new Client({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASS,
        database: process.env.DB_NAME,
        port: parseInt(process.env.DB_PORT!),
    })
  return client;
}

export async function sql(
  sql: string,
  values?: Array<any>
): Promise<QueryResult<any>> {
  const client = await getClient();
  await client.connect();
  const res = await client.query(sql, values);
  await client.end();
  return res;
}
