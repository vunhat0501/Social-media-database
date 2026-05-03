import { MigrationInterface, QueryRunner } from "typeorm";

export class FixIndexes1777814166887 implements MigrationInterface {
    name = 'FixIndexes1777814166887'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP INDEX "public"."IDX_b268ef13743e47999b36cb1470"`);
        await queryRunner.query(`CREATE UNIQUE INDEX "IDX_0f735e8be0f9f8502dfa704f1c" ON "auth" ("refresh_token") `);
        await queryRunner.query(`CREATE INDEX "IDX_9922406dc7d70e20423aeffadf" ON "auth" ("user_id") `);
        await queryRunner.query(`CREATE INDEX "idx_post_media_sequence" ON "post_media" ("post_id", "sequence_order") `);
        await queryRunner.query(`CREATE INDEX "IDX_4c675567d2a58f0b07cef09c13" ON "comments" ("user_id") `);
        await queryRunner.query(`CREATE INDEX "idx_post_comments_sort" ON "comments" ("post_id", "created_at") `);
        await queryRunner.query(`CREATE INDEX "IDX_c4f9a7bd77b489e711277ee598" ON "posts" ("user_id") `);
        await queryRunner.query(`CREATE INDEX "idx_user_post_timeline" ON "posts" ("user_id", "created_at") `);
        await queryRunner.query(`CREATE INDEX "IDX_116e9df57f5221cc1a77c3d1cf" ON "saved_posts" ("post_id") `);
        await queryRunner.query(`CREATE INDEX "idx_user_saved_sort" ON "saved_posts" ("user_id", "created_at") `);
        await queryRunner.query(`CREATE INDEX "idx_user_stories_active" ON "stories" ("user_id", "expires_at") `);
        await queryRunner.query(`CREATE INDEX "IDX_97672ac88f789774dd47f7c8be" ON "users" ("email") `);
        await queryRunner.query(`CREATE INDEX "idx_active_users_username" ON "users" ("user_name") WHERE deleted_at IS NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP INDEX "public"."idx_active_users_username"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_97672ac88f789774dd47f7c8be"`);
        await queryRunner.query(`DROP INDEX "public"."idx_user_stories_active"`);
        await queryRunner.query(`DROP INDEX "public"."idx_user_saved_sort"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_116e9df57f5221cc1a77c3d1cf"`);
        await queryRunner.query(`DROP INDEX "public"."idx_user_post_timeline"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_c4f9a7bd77b489e711277ee598"`);
        await queryRunner.query(`DROP INDEX "public"."idx_post_comments_sort"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_4c675567d2a58f0b07cef09c13"`);
        await queryRunner.query(`DROP INDEX "public"."idx_post_media_sequence"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_9922406dc7d70e20423aeffadf"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_0f735e8be0f9f8502dfa704f1c"`);
        await queryRunner.query(`CREATE INDEX "IDX_b268ef13743e47999b36cb1470" ON "stories" ("expires_at") `);
    }

}
