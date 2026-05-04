import { MigrationInterface, QueryRunner } from "typeorm";

export class UpdatedAtAndDeletedAt1777899363222 implements MigrationInterface {
    name = 'UpdatedAtAndDeletedAt1777899363222'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "auth" ADD "updated_at" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "comments" ADD "updated_at" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "comments" ADD "deleted_at" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "posts" ADD "updated_at" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "posts" ADD "deleted_at" TIMESTAMP`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "posts" DROP COLUMN "deleted_at"`);
        await queryRunner.query(`ALTER TABLE "posts" DROP COLUMN "updated_at"`);
        await queryRunner.query(`ALTER TABLE "comments" DROP COLUMN "deleted_at"`);
        await queryRunner.query(`ALTER TABLE "comments" DROP COLUMN "updated_at"`);
        await queryRunner.query(`ALTER TABLE "auth" DROP COLUMN "updated_at"`);
    }

}
